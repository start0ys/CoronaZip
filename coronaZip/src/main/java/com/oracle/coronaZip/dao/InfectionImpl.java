package com.oracle.coronaZip.dao;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.ibatis.session.SqlSession;
import org.jsoup.Jsoup;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import com.oracle.coronaZip.model.Board;
import com.oracle.coronaZip.model.Infection;
import com.oracle.coronaZip.model.News;
import com.oracle.coronaZip.model.User;

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
//				String recovery = item.getElementsByTagName("isolIngCnt").item(0).getChildNodes().item(0).getNodeValue();
				
				infection.setCity(city);
				infection.setTotal(total);
				infection.setAdd(add);
				infection.setLocal(local);
				infection.setOver(over);
//				infection.setRecovery(recovery);
				
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

	@Override
	public List<News> news() {
		List<News> news = new ArrayList<News>();
		String url = "https://www.google.co.kr/search?sxsrf=APq-WBvD_PX_sGWCGlILdD2n1E1NoLZksw:1643705557333&q=%EC%BD%94%EB%A1%9C%EB%82%98+%EB%89%B4%EC%8A%A4&tbm=nws&source=univ&tbo=u&sxsrf=APq-WBvD_PX_sGWCGlILdD2n1E1NoLZksw:1643705557333&sa=X&ved=2ahUKEwj2pfCukN71AhXS3WEKHf0yCYMQt8YBegQIAhAD&biw=976&bih=703&dpr=1.25";    //크롤링할 url지정
        org.jsoup.nodes.Document doc = null;        //Document에는 페이지의 전체 소스가 저장된다
	    try {
	    	doc = Jsoup.connect(url).get();
	    } catch (IOException e) {
	    	e.printStackTrace();
	    }
        //select를 이용하여 원하는 태그를 선택한다. select는 원하는 값을 가져오기 위한 중요한 기능이다.
        //                               ==>원하는 값들이 들어있는 덩어리를 가져온다
        Elements element = doc.select("g-card.ftSUBd"); 
        //Iterator을 사용하여 하나씩 값 가져오기
        //덩어리안에서 필요한부분만 선택하여 가져올 수 있다.
        Iterator<org.jsoup.nodes.Element> title = element.select("div.mCBkyc.nDgy9d").iterator();
        Iterator<org.jsoup.nodes.Element> content = element.select("div.GI74Re.nDgy9d").iterator();
        Iterator<org.jsoup.nodes.Element> link = element.select("a.WlydOe").iterator();
        for(int i = 0; i < 6; i++) {
        	News ns = new News();
        	ns.setTitle(title.next().text());
        	ns.setContent(content.next().text());
        	ns.setLink(link.next().attr("href"));
        	news.add(ns);
        }
		return news;
	}

	@Override
	public void join(User user) {
		session.insert("join", user);
	}

	@Override
	public int idChk(String id2) {
		int idChk = session.selectOne("idChk", id2);
		return idChk;
	}

	@Override
	public int login(User user) {
		int result = 0;
		String pw = session.selectOne("login", user);
		if(pw == null || pw.equals("")) {
			result = 1;  //조회를 못한경우 -> 존재하지않는 아이디
		}else if(!pw.equals(user.getPw())) {
			result = 2;  //비밀번호가 다른경우
		}else if(pw.equals(user.getPw())) {
			result = 3;  //로그인 성공
		}
		return result;
	}

	@Override
	public User user(String id2) {
		User user = session.selectOne("user", id2);
		return user;
	}

	@Override
	public String findId(User user) {
		String findId = session.selectOne("findId", user);
		return findId;
	}

	@Override
	public String findPw(User user) {
		String findPw = session.selectOne("findPw", user);
		return findPw;
	}

	@Override
	public void updatePw(User user) {
		session.update("updatePw", user);
	}

	@Override
	public void bWrite(Board board) {
		session.insert("bWrite", board);
	}

}
