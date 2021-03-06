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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.oracle.coronaZip.model.Board;
import com.oracle.coronaZip.model.Comment;
import com.oracle.coronaZip.model.Infection;
import com.oracle.coronaZip.model.Menu;
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
import java.util.StringTokenizer;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
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
		//?????? ??????
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		String today = sdf.format(date);
		//?????? ??????
		Date dDate = new Date();
		dDate = new Date(dDate.getTime()+(1000*60*60*24*-1));
		SimpleDateFormat dSdf = new SimpleDateFormat("yyyyMMdd", Locale.KOREA);
		String yesterday = dSdf.format(dDate);
		//????????? ?????????????????? - ?????? ????????? ???????????? ?????????????????? ?????? ??????????????????
		List<Infection> cnList = null;
//		Infection cn = null;
		if(is.cnList(today) == null || is.cn(today) == null) {
			cnList = is.cnList(yesterday);
//			cn = is.cn(yesterday);
		}else {
			cnList = is.cnList(today);
//			cn = is.cn(today);
		}
		//????????? ?????? ?????? ?????? ????????????
		List<News> news = is.news();
		List<Menu> menuList = bs.menuList();
		
		model.addAttribute("cnList", cnList);
//		model.addAttribute("cn", cn);
		model.addAttribute("news", news);
		model.addAttribute("menuList", menuList);
		model.addAttribute("activeMenu", "home");
		
		return "index";
	}
	
	@GetMapping(value = "center")
	public String center(Model model) {
		List<Menu> menuList = bs.menuList();
		model.addAttribute("menuList", menuList);
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
		List<Menu> menuList = bs.menuList();
		model.addAttribute("menuList", menuList);
		model.addAttribute("activeMenu", "join");
		return "join";
	}
	
	@PostMapping(value = "join")
	public String join2(User user) {
		user.setAddress(user.getBs_addr() + "|//|" + user.getDt_addr());
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
			messageHelper.setFrom("kimstartmail@gmail.com");  // ??????????????? ??????????????? ?????? ??????????????? ??????
			messageHelper.setTo(email);	 // ???????????? ?????????
			messageHelper.setSubject("?????? ?????????????????????."); // ??????????????? ????????? ????????????.
			messageHelper.setText("?????? ????????????????????? : " + user2.getPw()); // ?????? ??????
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
		
		List<Menu> menuList = bs.menuList();
		model.addAttribute("menuList", menuList);
		model.addAttribute("pg", pg);
		model.addAttribute("boardList", boardList);
		model.addAttribute("boardTotal", boardTotal);
		model.addAttribute("b_type", b_type);
		model.addAttribute("currentPage", currentPage2);
		model.addAttribute("activeMenu", "board");
		return "board";
	}
	
	@GetMapping(value = "bWrite")
	public String write(int b_type, Model model,String currentPage) {
		List<Menu> menuList = bs.menuList();
		model.addAttribute("menuList", menuList);
		model.addAttribute("b_type", b_type);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("activeMenu", "board");
		return "bWrite";
	}
	
	@PostMapping(value = "bWrite")
	public String write(HttpServletRequest request, MultipartFile file1, Board board, RedirectAttributes redirect,String currentPage)throws Exception {
		if(file1.isEmpty()) { 
			board.setB_upload("");
		}else {			
			String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
			String saveName = bs.uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath);
			board.setB_upload(saveName);
			
		}
		is.bWrite(board);
		redirect.addAttribute("b_type", board.getB_type());
		redirect.addAttribute("currentPage", currentPage);
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
		List<Menu> menuList = bs.menuList();
		model.addAttribute("menuList", menuList);
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
		List<Menu> menuList = bs.menuList();
		model.addAttribute("menuList", menuList);
		model.addAttribute("board", board);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("activeMenu", "board");
		return "bUpdate";
	}
	@PostMapping(value = "bUpdate")
	public String bUpdate2(HttpServletRequest request, MultipartFile file1, Board board,RedirectAttributes redirect, String currentPage) throws Exception {
		if(board.getB_upload() == "change" || board.getB_upload().equals("change")) { 		
			String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
			String saveName = bs.uploadFile(file1.getOriginalFilename(), file1.getBytes(), uploadPath);
			board.setB_upload(saveName);
		}
		String result = bs.bUpdate(board);
		redirect.addAttribute("b_type", board.getB_type());
		redirect.addAttribute("b_idx", board.getB_idx());
		redirect.addAttribute("currentPage", currentPage);
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
	@GetMapping(value = "fileDownLoad")
	public void fileDownload(HttpServletRequest request, HttpServletResponse response,String fileName) throws ServletException, IOException {
		try {
			  request.setCharacterEncoding("utf-8");
			  String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
			  String filePath = uploadPath + fileName;
			  File file = new File(filePath);
			  byte b[] = new byte[4096];
			  response.reset();
			  response.setContentType("application/octet-stream");
			  String Encoding = new String(fileName.getBytes("UTF-8"), "8859_1");
			  response.setHeader("Content-Disposition", "attachment; filename = " + Encoding);
			  FileInputStream in = new FileInputStream(filePath);
			  ServletOutputStream out2 = response.getOutputStream();
			  int numRead;
			  while((numRead = in.read(b, 0, b.length)) != -1){
			  out2.write(b, 0, numRead);
			  }  
			  out2.flush();
			  out2.close();
			  in.close();
 
		} catch (Exception e) {
			System.out.println(e.getMessage());
		} 
		
	}
	@GetMapping(value = "fileDelete")
	public void uploadFileDelete(HttpServletRequest request,String fileName) throws Exception{
	   try {
		   	String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
		  	String deleteFile = uploadPath + fileName;
		  	File file = new File(deleteFile); 
			if( file.exists() ){ 
				file.delete();
			}
		
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	@GetMapping(value = "userUpdate")
	public String userUpdate(HttpSession session, Model model) {
		User user2 = (User) session.getAttribute("user");
		User user = bs.getUser(user2.getId());
		StringTokenizer st = new StringTokenizer(user.getAddress(),"|//|");
		user.setBs_addr(st.nextToken());
		user.setDt_addr(st.nextToken());
		List<Menu> menuList = bs.menuList();
		model.addAttribute("menuList", menuList);
		model.addAttribute("user", user);
		model.addAttribute("activeMenu", "myPage");
		return "userUpdate";
	}
	@PostMapping(value = "userUpdate")
	public String updateUser(User user, RedirectAttributes redirect) {
		user.setAddress(user.getBs_addr() + "|//|" + user.getDt_addr());
		String result = bs.userUpdate(user);
		redirect.addAttribute("id", user.getId());
		return "redirect:userUpdate";
	}
	@GetMapping(value = "setMenu")
	public String setMenu(Model model) {
		List<Menu> menuList = bs.menuList();
		model.addAttribute("menuList", menuList);
		model.addAttribute("activeMenu", "setMenu");
		return "setMenu";
	}
	@ResponseBody
	@GetMapping(value = "menuSelect")
	public Menu menuSelect(String idx){
		return bs.menuSelect(idx);
	}
	@PostMapping(value = "updateMenu")
	public String menuUpdate(Menu menu) {
		String result = bs.menuUpdate(menu);
		return "redirect:setMenu";
	}
	@PostMapping(value = "addMenu")
	public String addUpdate(Menu menu) {
		System.out.println(menu);
		return "redirect:setMenu";
	}
}
