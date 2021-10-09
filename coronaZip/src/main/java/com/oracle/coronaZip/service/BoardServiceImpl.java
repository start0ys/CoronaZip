package com.oracle.coronaZip.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.coronaZip.dao.BoardDao;
import com.oracle.coronaZip.model.Board;

@Service
public class BoardServiceImpl implements BoardService{

	@Autowired
	private BoardDao bd;
	
	@Override
	public int boardTotal(int b_type) {
		int boardTotal = bd.boardTotal(b_type);
		return boardTotal;
	}

	@Override
	public List<Board> boardList(Board board) {
		List<Board> boardList = bd.boardList(board);
		return boardList;
	}

}
