package com.oracle.coronaZip.interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;


@Configuration
public class LoginConfiguration implements WebMvcConfigurer {
	LoginInterceptor interceptor = new LoginInterceptor();
	public void addInterceptors(InterceptorRegistry registry) {
	       registry.addInterceptor(interceptor).addPathPatterns(interceptor.interceptorPh);
	}
}
