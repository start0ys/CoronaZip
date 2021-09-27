package com.oracle.coronaZip.dao;

import java.util.List;

import com.oracle.coronaZip.model.Infection;
import com.oracle.coronaZip.model.News;

public interface InfectionDao {
	List<Infection> cnList(String day);
	Infection       cn(String day);
	List<News>      news();
}
