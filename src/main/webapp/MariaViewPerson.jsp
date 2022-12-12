<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.SQLException"%>
<%@page import="kr.human.jdbc.JDBCUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Title</title>
</head>
<body>
<%
	Connection conn = null; // 연결 객체 변수 준비
	Statement stmt = null; // 명령 객체 변수
	ResultSet rs = null; // 결과 객체 변수
	
	try{
		// 연결 얻기
		conn = JDBCUtil.getConnection(application.getRealPath("./db.properties"),"maria");
		conn.setAutoCommit(false); // 자동 커밋 해제
		//-------------------------------------------------------------------------
		// 이부분만 변경
		// out.println("연결 성공 : " + conn + "<br>");
		String sql = "select * from person order by idx desc";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(sql);
		out.println("Person 테이블의 내용<hr>");
		if(rs.next()) {
			do {
				out.println(rs.getInt("idx") + ". ");		
				out.println(rs.getString("name") + "(");		
				out.println(rs.getInt("age") + "세, ");		
				out.println(rs.getString("gender") + ")<br>");		
			} while(rs.next());
		}else{
			out.println("데이터가 없습니다.<br>");
		}
		//-------------------------------------------------------------------------
		conn.commit(); // 모든 명령이 에러가 없으면 DB에 적용
	}catch(SQLException e){
		JDBCUtil.rollback(conn); // 에러 발생시 모든 SQL 명령을 취소한다.
		e.printStackTrace();
	} finally{
		JDBCUtil.close(rs);
		JDBCUtil.close(stmt);
		JDBCUtil.close(conn); // 닫기
	}
%>

	<button onclick="location.href='mariaInsertForm.jsp'">추가하기</button>
</body>
</html>