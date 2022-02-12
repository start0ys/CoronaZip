package com.oracle.coronaZip.service;

import java.io.File;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.FileCopyUtils;

import com.oracle.coronaZip.dao.BoardDao;
import com.oracle.coronaZip.model.Board;
import com.oracle.coronaZip.model.Comment;
import com.oracle.coronaZip.model.Menu;
import com.oracle.coronaZip.model.User;

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

	@Override
	public String reUpdate(Map<String, String> param) {
		try {
			bd.reUpdate(param);
		} catch (Exception e) {
			return "댓글 수정 실패";
		}
		return null;
	}
	
	@Override
	public String uploadFile(String orginalName, byte[] fileData, String uploadPath) throws Exception{
		UUID uid = UUID.randomUUID();
		// Directory 생성
		File fileDirectory = new File(uploadPath);
		if(!fileDirectory.exists()) {
			fileDirectory.mkdirs();
		}
		String savedName = uid.toString() + "_" + orginalName;
		File target = new File(uploadPath,savedName);
		FileCopyUtils.copy(fileData, target);
		return savedName;
	}

	@Override
	public User getUser(String id) {
		return bd.getUser(id);
	}

	@Override
	public String userUpdate(User user) {
		try {
			bd.userUpdate(user);
		} catch (Exception e) {
			return "정보 수정 실패";
		}
		return null;
	}

	@Override
	public List<Menu> menuList() {
		return bd.menuList();
	}

}
