package com.oracle.coronaZip.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.oracle.coronaZip.model.Board;
import com.oracle.coronaZip.model.Comment;
import com.oracle.coronaZip.model.Infection;
import com.oracle.coronaZip.model.News;
import com.oracle.coronaZip.model.User;
import com.oracle.coronaZip.service.BoardService;
import com.oracle.coronaZip.service.InfectionService;
import com.oracle.coronaZip.service.Paging;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.InputStreamReader;

import org.apache.commons.collections4.map.HashedMap;
import org.json.XML;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.python.antlr.base.mod;
import org.python.util.PythonInterpreter;

@Controller
public class CzController {
	
	@Autowired
	private InfectionService is;
	@Autowired
	private BoardService bs;
	@Autowired
	private JavaMailSender mailSender;
	
	@GetMapping(value = "index")
	public String main(Model model) throws Exception {
		//오늘 날짜
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		String today = sdf.format(date);
		//어제 날짜
		Date dDate = new Date();
		dDate = new Date(dDate.getTime()+(1000*60*60*24*-1));
		SimpleDateFormat dSdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		String yesterday = dSdf.format(dDate);
		//확진자 정보가져오기 - 오늘 정보가 업데이트 안되어있으면 어제 정보가져오기
		List<Infection> cnList = null;
//		Infection cn = null;
		if(is.cnList(today) == null || is.cn(today) == null) {
			cnList = is.cnList(yesterday);
//			cn = is.cn(yesterday);
		}else {
			cnList = is.cnList(today);
//			cn = is.cn(today);
		}
		//코로나 관련 뉴스 정보 가져오기
		List<News> news = is.news();
		
		model.addAttribute("cnList", cnList);
//		model.addAttribute("cn", cn);
		model.addAttribute("news", news);
		model.addAttribute("activeMenu", "home");
		
		return "index";
	}
	
	@GetMapping(value = "center")
	public String center(Model model) {
		model.addAttribute("activeMenu", "center");
		return "center";
	}
	
	@GetMapping(value = "login")
	public String login() {
		return "login";
	}
	
	@PostMapping(value = "login")
	public String login2(HttpSession session, User user, Model model) {
		int result = is.login(user);
		if(result == 1 || result == 2) {
			model.addAttribute("result",result);
			return "loginFail";
		}else {
			User user2 = is.user(user.getId());
			session.setAttribute("user", user2);
			return "redirect:/index";		
		}			
	}

	@GetMapping(value = "logout")
    public String logout(HttpSession session , HttpServletRequest request) {
        session.invalidate(); 
//        String referer = request.getHeader("Referer");
        return "redirect:/index";
    }
	
	@GetMapping(value = "join")
	public String join(Model model) {
		model.addAttribute("activeMenu", "join");
		return "join";
	}
	
	@PostMapping(value = "join")
	public String join2(User user) {
		user.setAddress(user.getBs_addr() + " " + user.getDt_addr());
		is.join(user);
		return "redirect:/index";
	}
	
	@ResponseBody
	@PostMapping(value = "idChk")
	public int idChk(String id2) {
		int idChk = is.idChk(id2);
		return idChk;
	}
	
	@GetMapping(value = "findId")
	public String findId() {
		return "findId";
	}
	@PostMapping(value = "findId")
	public String findId(User user, Model model) {
		String result = is.findId(user);
		model.addAttribute("result", result);
		return "findIdResult";
	}
	@GetMapping(value = "findPw")
	public String findPw() {
		return "findPw";
	}

	@PostMapping(value = "findPw")
	public String findPw(User user,HttpServletRequest request, Model model) throws MessagingException {
		String email = is.findPw(user);
		int result = 0;
		if(email == null || email.equals("")) {
			result = 1;
		}else {
			User user2 = new User();
			user2.setId(user.getId());
			user2.setPw((int)(Math.random() * 999999) + 1 + "");
			is.updatePw(user2);
			
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message,true,"UTF-8");
			messageHelper.setFrom("kimstartmail@gmail.com");  // 보내는사람 생략하거나 하면 정삭작동을 안함
			messageHelper.setTo(email);	 // 받는사람 이메일
			messageHelper.setSubject("임시 비밀번호입니다."); // 메일제목은 생략이 가능하다.
			messageHelper.setText("임시 비밀번호입니다 : " + user2.getPw()); // 메일 내용
			mailSender.send(message);
			result = 2;
		}
		model.addAttribute("result", result);
		return "findPwResult";
	}
	
	@GetMapping(value = "board")
	public String board(int b_type, Model model, String currentPage, Board board) {
		int boardTotal = bs.boardTotal(b_type);
		
		Paging pg = new Paging(boardTotal, currentPage);
		board.setB_type(b_type);
		board.setStart(pg.getStart());
		board.setEnd(pg.getEnd());
		
		List<Board> boardList = bs.boardList(board);
		
		String currentPage2 = StringUtils.isEmpty(currentPage) ? "1" : currentPage;
		model.addAttribute("pg", pg);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardTotal", boardTotal);
		model.addAttribute("b_type", b_type);
		model.addAttribute("currentPage", currentPage2);
		model.addAttribute("activeMenu", "board");
		return "board";
	}
	
	@GetMapping(value = "bWrite")
	public String write(int b_type, Model model) {
		model.addAttribute("b_type", b_type);
		model.addAttribute("activeMenu", "board");
		return "bWrite";
	}
	
	@PostMapping(value = "bWrite")
	public String write(Board board, RedirectAttributes redirect) {
		is.bWrite(board);
		redirect.addAttribute("b_type", board.getB_type());
		return "redirect:board";
	}
	
	@GetMapping(value = "bView")
	public String bView(Model model, String b_type, String b_idx, String currentPage,String pC_idx) {
		Map<String, String> param = new HashedMap<String, String>();
		param.put("b_type", b_type);
		param.put("b_idx", b_idx);
		Board board = bs.boardView(param);
		int cListTotal = bs.cListTotal(Integer.parseInt(b_idx));
		List<Comment> cList = bs.cList(Integer.parseInt(b_idx));
		int c_idx =  StringUtils.isEmpty(pC_idx) ? 0 : Integer.parseInt(pC_idx);
		int ref = 0, re_level = 0, re_step = 0;
		if(c_idx > 0) {
			Comment comment = bs.comment(c_idx);
			ref = comment.getRef();
			re_level = comment.getRe_level();
			re_step = comment.getRe_step();
		}
		model.addAttribute("ref", ref);
		model.addAttribute("re_level", re_level);
		model.addAttribute("re_step", re_step);
		model.addAttribute("c_idx", c_idx);
		
		model.addAttribute("board", board);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("cListTotal", cListTotal);
		model.addAttribute("cList", cList);
		model.addAttribute("activeMenu", "board");
		return "bView";
	}
	@PostMapping(value = "reWrite")
	public String reWrite(Model model, String c_nickname, String id, int b_idx, int c_idx,int b_type, int ref, int re_level,int re_step,String c_vaccine,String c_content,RedirectAttributes redirect, String currentPage) {
		Comment comment = new Comment();
		comment.setB_idx(b_idx);
		comment.setId(id);
		comment.setC_nickname(c_nickname);
		comment.setC_content(c_content);
		comment.setC_idx(c_idx);
		comment.setRef(ref);
		comment.setRe_step(re_step);
		comment.setRe_level(re_level);
		comment.setC_vaccine(c_vaccine);
		String result = bs.result(comment);
		redirect.addAttribute("b_type", b_type);
		redirect.addAttribute("b_idx", b_idx);
		redirect.addAttribute("currentPage", currentPage);
		return "redirect:bView";
	}
	@GetMapping(value = "reDelete")
	public String reDelete(Model model,int c_idx, int b_idx, int b_type,RedirectAttributes redirect, String currentPage) {
		String result = bs.reDelete(c_idx);
		redirect.addAttribute("b_type", b_type);
		redirect.addAttribute("b_idx", b_idx);
		redirect.addAttribute("currentPage", currentPage);
		return "redirect:bView";
	}
	@GetMapping(value = "bUpdate")
	public String bUpdate(Model model, String b_type, String b_idx, String currentPage) {
		Map<String, String> param = new HashedMap<String, String>();
		param.put("b_type", b_type);
		param.put("b_idx", b_idx);
		Board board = bs.boardView(param);
		model.addAttribute("board", board);
		model.addAttribute("activeMenu", "board");
		return "bUpdate";
	}
	@PostMapping(value = "bUpdate")
	public String bUpdate2(Board board,RedirectAttributes redirect) {
		String result = bs.bUpdate(board);
		redirect.addAttribute("b_type", board.getB_type());
		redirect.addAttribute("b_idx", board.getB_idx());
		return "redirect:bView";
	}
	@GetMapping(value = "bDelete")
	public String bDelete(RedirectAttributes redirect,int b_type,int b_idx,String currentPage) {
		String result = bs.bDelete(b_idx);
		redirect.addAttribute("b_type", b_type);
		redirect.addAttribute("b_idx", b_idx);
		redirect.addAttribute("currentPage", currentPage);
		return "redirect:board";
	}
	@PostMapping(value = "reUpdate")
	public String reUpdate(int b_idx, String c_idx, int b_type,String c_content,String currentPage,RedirectAttributes redirect) {
		Map<String, String> param = new HashedMap<String, String>();
		param.put("c_idx", c_idx);
		param.put("c_content", c_content);
		String result = bs.reUpdate(param);
		redirect.addAttribute("b_type", b_type);
		redirect.addAttribute("b_idx", b_idx);
		redirect.addAttribute("currentPage", currentPage);
		return "redirect:bView";
	}
	@GetMapping(value = "userUpdate")
	public String userUpdate(Model model) {
		return "userUpdate";
	}
	@GetMapping(value = "includeTest")
	public String userUpdate2(Model model) {
		model.addAttribute("activeMenu", "home");
		return "includeTest";
	}
}
