package com.oracle.coronaZip.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Infection {
	String city;   String total;  String add;
	String local;  String over;   String recovery;
	
	String stateDt;String totCnt; String exam;
	String clear;  String death;
}
