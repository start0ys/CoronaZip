package com.oracle.coronaZip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.coronaZip.dao.InfectionDao;
import com.oracle.coronaZip.model.Infection;
import com.oracle.coronaZip.model.News;
import com.oracle.coronaZip.model.User;

@Service
public class InfectionServiceImpl implements InfectionService{

	@Autowired
	private InfectionDao id;
	
	@Override
	public List<Infection> cnList(String day) {
		List<Infection> cnList = id.cnList(day);
		return cnList;
	}

	@Override
	public Infection cn(String day) {
		Infection cn = id.cn(day);
		return cn;
	}

	@Override
	public List<News> news() {
		List<News> news = id.news();
		return news;
	}

	@Override
	public void join(User user) {
		id.join(user);
	}

	@Override
	public int idChk(String id2) {
		int idChk = id.idChk(id2);
		return idChk;
	}

	@Override
	public int login(User user) {
		int login = id.login(user);
		return login;
	}

}
