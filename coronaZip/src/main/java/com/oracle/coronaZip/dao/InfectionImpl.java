package com.oracle.coronaZip.dao;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.oracle.coronaZip.model.Infection;

@Repository
public class InfectionImpl implements InfectionDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public List<Infection> cnList(String day)  {
		List<Infection> cnList = new ArrayList<Infection>();
    	String url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19SidoInfStateJson?serviceKey=4GfH2i3tXiTAlgB1urJs7gd3SalAlH0w9dTp3ytpzhhhq8CcaYTF0rMwwVtATbZVLNUw1hLIc1as6IHBPxFvMA%3D%3D&pageNo=1&numOfRows=10&startCreateDt="+day+"&endCreateDt="+day;
    	 	
    	try {
    	   	URL obj = new URL(url);
        	HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        	con.setRequestMethod("GET");
        	con.setRequestProperty("User-Agent", "Mozilla/5.0");
        	con.getResponseCode();
        	
        	BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        	String inputLine;
        	StringBuffer response = new StringBuffer();
        	
        	while ((inputLine = in.readLine()) != null) {
        		//System.out.println(inputLine);
        		response.append(inputLine);
        	}
        	
        	in.close();
        	
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			
			FileOutputStream output = new FileOutputStream("./CORONA");
			output.write(response.toString().getBytes());
			output.close();
			
			Document doc = dBuilder.parse("./CORONA");
			doc.getDocumentElement().normalize();
			
			Element body = (Element) doc.getElementsByTagName("body").item(0);
			Element items = (Element) body.getElementsByTagName("items").item(0);
			for(int i = 18; i>=0;i--) {
				Infection infection = new Infection();
				Element item = (Element) items.getElementsByTagName("item").item(i);
				String city = item.getElementsByTagName("gubun").item(0).getChildNodes().item(0).getNodeValue();
				String total = item.getElementsByTagName("defCnt").item(0).getChildNodes().item(0).getNodeValue();
				String add = item.getElementsByTagName("incDec").item(0).getChildNodes().item(0).getNodeValue();
				String local = item.getElementsByTagName("localOccCnt").item(0).getChildNodes().item(0).getNodeValue();
				String over = item.getElementsByTagName("overFlowCnt").item(0).getChildNodes().item(0).getNodeValue();
				String recovery = item.getElementsByTagName("isolIngCnt").item(0).getChildNodes().item(0).getNodeValue();
				
				infection.setCity(city);
				infection.setTotal(total);
				infection.setAdd(add);
				infection.setLocal(local);
				infection.setOver(over);
				infection.setRecovery(recovery);
				
				cnList.add(infection);
							
			}
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			//e.printStackTrace();
			return null;
		}
		return cnList;
	}

	@Override
	public Infection cn(String day) {
    	String url = "http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson?serviceKey=4GfH2i3tXiTAlgB1urJs7gd3SalAlH0w9dTp3ytpzhhhq8CcaYTF0rMwwVtATbZVLNUw1hLIc1as6IHBPxFvMA%3D%3D&pageNo=1&numOfRows=10&startCreateDt="+day+"&endCreateDt="+day;
    	Infection cn = new Infection();	
    	try {
    	   	URL obj = new URL(url);
        	HttpURLConnection con = (HttpURLConnection) obj.openConnection();
        	con.setRequestMethod("GET");
        	con.setRequestProperty("User-Agent", "Mozilla/5.0");
        	con.getResponseCode();
        	
        	BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        	String inputLine;
        	StringBuffer response = new StringBuffer();
        	
        	while ((inputLine = in.readLine()) != null) {
        		//System.out.println(inputLine);
        		response.append(inputLine);
        	}
        	
        	in.close();
        	
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			
			FileOutputStream output = new FileOutputStream("./CORONA");
			output.write(response.toString().getBytes());
			output.close();
			
			Document doc = dBuilder.parse("./CORONA");
			doc.getDocumentElement().normalize();
			
			Element body = (Element) doc.getElementsByTagName("body").item(0);
			Element items = (Element) body.getElementsByTagName("items").item(0);
			
			Element item = (Element) items.getElementsByTagName("item").item(0);
			String stateDt = item.getElementsByTagName("stateDt").item(0).getChildNodes().item(0).getNodeValue();
			String totCnt = item.getElementsByTagName("decideCnt").item(0).getChildNodes().item(0).getNodeValue();
			String exam = item.getElementsByTagName("examCnt").item(0).getChildNodes().item(0).getNodeValue();
			String clear = item.getElementsByTagName("clearCnt").item(0).getChildNodes().item(0).getNodeValue();
			String death = item.getElementsByTagName("deathCnt").item(0).getChildNodes().item(0).getNodeValue();
			
			cn.setStateDt(stateDt);
			cn.setTotCnt(totCnt);
			cn.setExam(exam);
			cn.setClear(clear);
			cn.setDeath(death);
					
		} catch (Exception e) {
			System.out.println(e.getMessage());
			//e.printStackTrace();
			return null;
		}
		return cn;
	}

}
