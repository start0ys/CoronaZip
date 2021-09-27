package com.oracle.coronaZip.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Infection {
	private String city;   private String total;  private String add;
	private String local;  private String over;   private String recovery;
	
	private String stateDt;private String totCnt; private String exam;
	private String clear;  private String death;
}
