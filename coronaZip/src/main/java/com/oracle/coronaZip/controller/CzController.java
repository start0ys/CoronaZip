package com.oracle.coronaZip.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.oracle.coronaZip.model.Infection;
import com.oracle.coronaZip.model.News;
import com.oracle.coronaZip.model.User;
import com.oracle.coronaZip.service.InfectionService;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

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
		Infection cn = null;
		if(is.cnList(today) == null || is.cn(today) == null) {
			cnList = is.cnList(yesterday);
			cn = is.cn(yesterday);
		}else {
			cnList = is.cnList(today);
			cn = is.cn(today);
		}
		//코로나 관련 뉴스 정보 가져오기
		List<News> news = is.news();
		
		model.addAttribute("cnList", cnList);
		model.addAttribute("cn", cn);
		model.addAttribute("news", news);
		
		return "index";
	}
	
	@GetMapping(value = "center")
	public String center() {
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
        String referer = request.getHeader("Referer");
        return "redirect:"+ referer;
    }
	
	@GetMapping(value = "join")
	public String join() {
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
	@Autowired
	private JavaMailSender mailSender;
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
	
	
}
