package kr.human.jdbc;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

// import org.apache.logging.log4j.LogManager;
// import org.apache.logging.log4j.Logger;

import lombok.extern.slf4j.Slf4j;


@Slf4j
public class JDBCUtil {
	// 데이터가 없으며 자주 사용되는 메서드를만 모아놓은 클래스들은 자동으로 메모리에
	// 로딩 도히도록 메서드를 static으로 만들면 좋다.
	
	// private static final Logger logger = LogManager.getLogger(JDBCUtil.class);
	
	// 경로를 받아 프로퍼티 파일을 읽어서 리턴해주는 메서드
	private static Properties readProperties(String path) {
		Properties properties = new Properties();
		try(FileReader fr = new FileReader(path)){
			properties.load(fr);
			// log.debug("프로퍼티 파일 : " + properties); // log4j 방식
			log.info("프로퍼티 파일 : {}", properties); // slf4j 방식
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return properties;
	}
	
	// DB의 Connection 객체를 리턴해주는 메서드 1
	public static Connection getConnection(String path) {
		log.info("getConnection(String path) 호출 : {}", path);
		Connection conn = null; // 리턴할 객체부터 선언
		Properties properties = readProperties(path); // 프로퍼티 파일읽기
		try {
			// 드라이버 클래스 로딩
			Class.forName( properties.getProperty("o.driverClass"));
			// 연결
			conn = DriverManager.getConnection(
					properties.getProperty("o.url"),
					properties.getProperty("o.user"),
					properties.getProperty("o.password")
					);					
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		log.info("getConnection(String path) 리턴 : {}", conn);
		return conn;
	}
	// DB의 Connection 객체를 리턴해주는 메서드 2
	public static Connection getConnection(String path, String dbName) {
		log.info("getConnection(String path, String dbName) 호출 : {},{}", path, dbName);
		Connection conn = null; // 리턴할 객체부터 선언
		Properties properties = readProperties(path); // 프로퍼티 파일읽기
		try {
			switch (dbName) {
			case "oracle":
				// 드라이버 클래스 로딩
				Class.forName( properties.getProperty("o.driverClass"));
				// 연결
				conn = DriverManager.getConnection(
						properties.getProperty("o.url"),
						properties.getProperty("o.user"),
						properties.getProperty("o.password")
						);					
				break;
			case "maria":
				// 드라이버 클래스 로딩
				Class.forName( properties.getProperty("m.driverClass"));
				// 연결
				conn = DriverManager.getConnection(
						properties.getProperty("m.url"),
						properties.getProperty("m.user"),
						properties.getProperty("m.password")
						);					
				break;
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		log.info("getConnection(String path, String dbName) 리턴 : {}", conn);
		return conn;
	}	
	
	// 닫기 메서드 3개
	public static void close(Connection conn) {
		try {
			if(conn!=null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static void close(Statement stmt) {
		try {
			if(stmt!=null) stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public static void close(ResultSet rs) {
		try {
			if(rs!=null) rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// 롤백 메서드 1개
	public static void rollback(Connection conn) {
		try {
			if(conn!=null) conn.rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void main(String[] args) {
		Connection conn = null;
		try {
			conn = getConnection("src/main/resources/db.properties","oracle");
			
		} finally {
			try { if(conn!=null) conn.close(); } catch (SQLException e) {e.printStackTrace();}
		}
	}
}
