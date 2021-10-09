package com.oracle.coronaZip.model;


import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Board {
	private int b_idx;          private String id;          private int b_type;
	private String b_title;     private String b_nickname;  private Date b_regdate;
	private String b_content;   private int b_count;        private String b_upload;
	private int b_notice;
	
	//조회용
	private int start;          private int end;
}
