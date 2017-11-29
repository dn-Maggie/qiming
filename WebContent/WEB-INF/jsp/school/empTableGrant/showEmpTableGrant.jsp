<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html  >
<html>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<head>
<base href="<%=basePath%>">

<%@ include file="../../common/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/styles/extends/css/expenseAccount.css" />
<script type="text/javascript">
	$(function() {
		//绑定提交按钮click事件
		$("#close_button").click(function() {
			window.parent.closeShow();
		});
	});
</script>
</head>

<body>
	<div class="wrap">
		<input type="hidden" id="edit_id" name="id" type="text"
			value="${empTableGrant.id}" />
		<div class="top_head">
			<h2 class="top_name">餐补申请</h2>
			<div class="time_bg"
				style="top: 40px; left: 0px; height: 25px; line-height: 25px; position: absolute; width: 220px">
				<span>申请时间：</span> <input id="edit_createTime" name="createTime"
					class="input_select" style="height: 25px; width: 100px"
					value="${empTableGrant.createTime}" readonly /> <i
					class="search_time_ico2" style="top: 6px;"></i>
			</div>
		</div>

		<div class="center_body">
			<table class="table">
				<tr>
					<td class="inputLabelTd"><span class="required">*</span>所属部门：</td>
					<td class="inputTd"><input id="edit_deptName" name="deptName"
						type="text" class="text" value="${empTableGrant.empDept}" readonly />
					</td>
					<td class="inputLabelTd"><span class="required">*</span>申请人：</td>
					<td class="inputTd"><input id="edit_enterName"
						name="enterName" type="text" class="text"
						value="${empTableGrant.empNickName}" readonly /></td>
				</tr>
				<tr class="trDetails" style="height: 140px;">
					<td class="inputLabelTd"><span class="required">*</span>申请理由：</td>
					<td class="inputTd" colspan="3"><textarea class="text"
							name="reason" id="edit_reason" readonly>${empTableGrant.reason}</textarea>
					</td>
				</tr>
				<tr>
					<td class="inputLabelTd">补助日期日起：</td>
					<td class="inputTd">
						<div class="time_bg" style="width: 98%;">
							<input id="edit_grantDateStart" name="grantDateStart" type="text"
								class="text" value="${empTableGrant.grantDateStart}" readonly />
						</div>
					</td>
					<td class="inputLabelTd">补助日期日止：</td>
					<td class="inputTd">
						<div class="time_bg" style="width: 98%;">
							<input id="edit_grantDateEnd" name="grantDateEnd" type="text"
								class="text" value="${empTableGrant.grantDateEnd}" readonly />
						</div>
					</td>
				</tr>
				<tr>
					<td class="inputLabelTd">补助次数：</td>
					<td class="inputTd"><input id="edit_grantTime"
						name="grantTime" type="number" class="text"
						value="${empTableGrant.grantTime}" readonly /></td>
					<td class="inputLabelTd">餐补合计：</td>
					<td class="inputTd"><input id="edit_tableMoney"
						name="tableMoney" type="number" class="text"
						value="${empTableGrant.tableMoney}" readonly /></td>
				</tr>
				<tr>
					<td class="inputLabelTd"><span class="required">*</span>部门经理：
					</td>
					<td class="inputTd"><input id="edit_deptLeader"
						name="deptLeader" type="text" class="text"
						value="${empTableGrant.deptLeader}" readonly /></td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
