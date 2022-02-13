package com.oracle.coronaZip.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Menu {
	private int idx;		private int type; 		private int groupnum;
	private String id;	    private String name;	private String link;
	private String icon;
}
