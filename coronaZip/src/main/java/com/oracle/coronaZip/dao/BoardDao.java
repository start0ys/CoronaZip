package com.oracle.coronaZip.dao;

import java.util.List;

import com.oracle.coronaZip.model.Board;

public interface BoardDao {
	int            boardTotal(int b_type);
	List<Board>    boardList(Board board);
}
