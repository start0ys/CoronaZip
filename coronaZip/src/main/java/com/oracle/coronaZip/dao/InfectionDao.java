package com.oracle.coronaZip.dao;

import java.util.List;

import com.oracle.coronaZip.model.Infection;

public interface InfectionDao {
	List<Infection> cnList(String day);
	Infection       cn(String day);
}
