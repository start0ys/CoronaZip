package com.oracle.coronaZip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.coronaZip.dao.InfectionDao;
import com.oracle.coronaZip.model.Infection;

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

}
