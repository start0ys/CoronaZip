package com.oracle.coronaZip.dao;

import java.util.List;

import com.oracle.coronaZip.model.Board;
import com.oracle.coronaZip.model.Infection;
import com.oracle.coronaZip.model.News;
import com.oracle.coronaZip.model.User;

public interface InfectionDao {
	List<Infection> cnList(String day);
	Infection       cn(String day);
	List<News>      news();
	void            join(User user);
	int             idChk(String id2);
	int             login(User user);
	User            user(String id2);
	String          findId(User user);
	String          findPw(User user);
	void            updatePw(User user);
	void			bWrite(Board board);
}
