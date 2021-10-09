package com.oracle.coronaZip.service;

import java.util.List;

import com.oracle.coronaZip.model.Board;

public interface BoardService {
	int            boardTotal(int b_type);
	List<Board>    boardList(Board board);
}
