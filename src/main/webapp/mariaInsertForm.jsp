<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>데이터 저장</title>
</head>
<body>
	<form action="mariaInsertOK.jsp" method = "post">
	<fieldset>
		<legend>저장 폼</legend>
		이름 : <input type="text" name="name" id = "name" placeholder="이름" required="required" /> <br />
		나이 : <input type="number" name="age" min = "1" max="150" value = "20"/> <br />
		성별 :
		<label> <input type="radio" name="gender" value="M" /> 남자 </label>
		<label> <input type="radio" name="gender" value="F" checked="checked" /> 여자 </label> <br />
		<input type="submit" value="저장하기" /> 
		<input type="reset" value="다시쓰기" /> 
	</fieldset>
	</form>
</body>
</html>