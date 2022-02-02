package com.oracle.coronaZip.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.coronaZip.dao.BoardDao;
import com.oracle.coronaZip.model.Board;
import com.oracle.coronaZip.model.Comment;

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

	@Override
	public Board boardView(Map<String, String> param) {
		bd.bCountUp(param);
		return bd.boardView(param);
	}

	@Override
	public List<Comment> cList(int b_idx) {
		return bd.cList(b_idx);
	}

	@Override
	public int cListTotal(int b_idx) {
		return bd.cListTotal(b_idx);
	}

	@Override
	public Comment comment(int c_idx) {
		return bd.comment(c_idx);
	}

	@Override
	public String result(Comment comment) {
		int c_idx = comment.getC_idx();
		try {
			if(c_idx > 0) {
				bd.reUpdate(comment);
			}
			bd.reInsert(comment);
		} catch (Exception e) {
			return "댓글 작성 실패";
		}
		return null;
	}

	@Override
	public String reDelete(int c_idx) {
		try {
			bd.reDelete(c_idx);
		} catch (Exception e) {
			return "댓글 삭제 실패";
		}
		return null;
	}

	@Override
	public String bUpdate(Board board) {
		try {
			bd.bUpdate(board);
		} catch (Exception e) {
			return "게시글 수정 실패";
		}
		return null;
	}

	@Override
	public String bDelete(int b_idx) {
		try {
			bd.bDelete(b_idx);
		} catch (Exception e) {
			return "게시글 삭제 실패";
		}
		return null;
	}

}
