package com.oracle.coronaZip.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class User {
	//db연결용
	private String name;    private  int   birth;     private String sex;
	private String id;      private String pw;        private String nickname;
	private String email;   private  int   postcode;  private String address;
	private String vaccine;
	//조회용
	private String bs_addr; private String dt_addr;
}
