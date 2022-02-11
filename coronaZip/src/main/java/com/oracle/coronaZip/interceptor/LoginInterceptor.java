package com.oracle.coronaZip.interceptor;

import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.oracle.coronaZip.model.User;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	public List interceptorPh = Arrays.asList("/index/**", "/center/**",  "/join/**", "/login/**", "/board/**", "/bWrite/**", "/bView/**", "/bUpdate/**");
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)throws Exception{

        return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception{
	    HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if ( user == null ){
        }else {
        	modelAndView.addObject("user", user);
        }
	}
}
