package com.oracle.coronaZip.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.oracle.coronaZip.model.Infection;
import com.oracle.coronaZip.service.InfectionService;

import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

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

		System.out.println(today);
		System.out.println(yesterday);
		
		List<Infection> cnList = is.cnList(today);
		Infection cn = is.cn(today);
		
		model.addAttribute("cnList", cnList);
		model.addAttribute("cn", cn);
		
		return "index";
	}

	
}
