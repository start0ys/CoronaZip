package com.oracle.coronaZip.service;

import java.util.List;

import com.oracle.coronaZip.model.Infection;

public interface InfectionService {
	List<Infection> cnList();
	Infection       cn();
}
