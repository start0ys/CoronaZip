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
import java.util.ArrayList;
import java.util.List;

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
		
		List<Infection> cnList = is.cnList();
		Infection cn = is.cn();
		
		model.addAttribute("cnList", cnList);
		model.addAttribute("cn", cn);
		
		return "index";
	}

	
}
