package com.oracle.coronaZip.service;

import java.util.List;
import java.util.Map;

import com.oracle.coronaZip.model.Board;
import com.oracle.coronaZip.model.Comment;
import com.oracle.coronaZip.model.Menu;
import com.oracle.coronaZip.model.User;

public interface BoardService {
	int            boardTotal(int b_type);
	List<Board>    boardList(Board board);
	Board          boardView(Map<String, String> param);
	List<Comment>  cList(int b_idx);
	int            cListTotal(int b_idx);
	Comment        comment(int c_idx);
	String		   result(Comment comment);
	String         reDelete(int c_idx);
	String         bUpdate(Board board);
	String         bDelete(int b_idx);
	String		   reUpdate(Map<String, String> param);
	String         uploadFile(String orginalName, byte[] fileData, String uploadPath) throws Exception;
	User		   getUser(String id);
	String         userUpdate(User user);
	List<Menu>	   menuList();
	Menu		   menuSelect(String idx);
	String         menuUpdate(Menu menu);
}
