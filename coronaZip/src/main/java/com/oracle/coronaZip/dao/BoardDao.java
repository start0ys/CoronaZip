package com.oracle.coronaZip.dao;

import java.util.List;
import java.util.Map;

import com.oracle.coronaZip.model.Board;
import com.oracle.coronaZip.model.Comment;
import com.oracle.coronaZip.model.Menu;
import com.oracle.coronaZip.model.User;

public interface BoardDao {
	int            boardTotal(int b_type);
	List<Board>    boardList(Board board);
	Board          boardView(Map<String, String> param);
	List<Comment>  cList(int b_idx);
	void           bCountUp(Map<String, String> param);
	int            cListTotal(int b_idx);
	Comment        comment(int c_idx);
	void           reUpdate(Comment comment);
	void           reInsert(Comment comment);
	void           reDelete(int c_idx);
	void           bUpdate(Board board);
	void           bDelete(int b_idx);
	void		   reUpdate(Map<String, String> param);
	User		   getUser(String id);
	void		   userUpdate(User user);
	List<Menu>	   menuList();
	Menu		   menuSelect(String idx);
	void           menuUpdate(Menu menu);
}
