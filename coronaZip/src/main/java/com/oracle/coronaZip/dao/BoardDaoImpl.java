package com.oracle.coronaZip.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.coronaZip.model.Board;
import com.oracle.coronaZip.service.Paging;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSession session;
	
	@Override
	public int boardTotal(int b_type) {
		int boardTotal = session.selectOne("boardTotal", b_type);
		return boardTotal;
	}

	@Override
	public List<Board> boardList(Board board) {
		List<Board> boardList = session.selectList("boardList", board);
		return boardList;
	}

}
