<%@page import="java.sql.SQLException"%>
<%@page import="kr.human.jdbc.JDBCUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oracle Conn</title>
</head>
<body>
<%
	Connection conn = null; // 변수 준비
	try{
		// 연결 얻기
		conn = JDBCUtil.getConnection(application.getRealPath("./db.properties"), "maria");
		conn.setAutoCommit(false); // 자동 커밋 해제
		//-------------------------------------------------------------------------
		// 이부분만 변경
		out.println("연결 성공 : " + conn + "<br>");
		
		//-------------------------------------------------------------------------
		conn.commit(); // 모든 명령이 에러가 없으면 DB에 적용
	}catch(SQLException e){
		JDBCUtil.rollback(conn); // 에러 발생시 모든 SQL 명령을 취소한다.
		e.printStackTrace();
	} finally{
		JDBCUtil.close(conn); // 닫기
	}
	
	
%>
</body>
</html>