package com.oracle.coronaZip.service;

import java.util.List;
import java.util.Map;

import com.oracle.coronaZip.model.Board;
import com.oracle.coronaZip.model.Comment;

public interface BoardService {
	int            boardTotal(int b_type);
	List<Board>    boardList(Board board);
	Board          boardView(Map<String, String> param);
	List<Comment>  cList(int b_idx);
	int            cListTotal(int b_idx);
	Comment        comment(int c_idx);
	String		   result(Comment comment);
}
