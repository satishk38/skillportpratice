package com.mycompany.web;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class EchoParameterValueServlet extends HttpServlet {
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
	    throws ServletException, IOException{
		
		String echo = req.getParameter("echo");
		resp.getWriter().println(echo);
		resp.setStatus(HttpServletResponse.SC_OK);
		
		System.out.println("*** do get**");
	  // comment
	}

}
