package com.oracle.coronaZip.model;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Comment {
	private int c_idx;           private int b_idx;           private String id;
	private String c_nickname;   private String c_content;
	private int ref;             private int re_step;         private int re_level;
	private Date c_regdate;
}
