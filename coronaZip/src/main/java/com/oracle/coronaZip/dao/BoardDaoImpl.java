package com.oracle.coronaZip.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.oracle.coronaZip.model.Board;
import com.oracle.coronaZip.model.Comment;
import com.oracle.coronaZip.model.Menu;
import com.oracle.coronaZip.model.User;
import com.oracle.coronaZip.service.Paging;

import oracle.net.aso.b;

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

	@Override
	public Board boardView(Map<String, String> param) {
		return session.selectOne("boardView", param);
	}

	@Override
	public List<Comment> cList(int b_idx) {
		return session.selectList("cList", b_idx);
	}

	@Override
	public void bCountUp(Map<String, String> param) {
		session.update("bCountUp", param);
	}

	@Override
	public int cListTotal(int b_idx) {
		return session.selectOne("cListTotal", b_idx);
	}

	@Override
	public Comment comment(int c_idx) {
		return session.selectOne("comment", c_idx);
	}

	@Override
	public void reUpdate(Comment comment) {
		session.update("reUpdate", comment);
	}

	@Override
	public void reInsert(Comment comment) {
		session.insert("reInsert", comment);
	}

	@Override
	public void reDelete(int c_idx) {
		session.delete("reDelete", c_idx);
	}

	@Override
	public void bUpdate(Board board) {
		session.update("bUpdate", board);
	}

	@Override
	public void bDelete(int b_idx) {
		session.delete("bDelete", b_idx);
	}

	@Override
	public void reUpdate(Map<String, String> param) {
		session.update("cmtUpdate", param);
	}

	@Override
	public User getUser(String id) {
		return session.selectOne("getUser", id);
	}

	@Override
	public void userUpdate(User user) {
		session.update("userUpdate", user);
	}

	@Override
	public List<Menu> menuList() {
		return session.selectList("getMenu");
	}

	@Override
	public Menu menuSelect(String idx) {
		return session.selectOne("menuSelect", idx);
	}

	@Override
	public void menuUpdate(Menu menu) {
		session.update("menuUpdate", menu);
	}

}
