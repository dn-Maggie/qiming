<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/styles/extends/css/expenseAccount.css" />
<script type="text/javascript">
 var createDate = new Date().format('yyyy-MM-dd hh:mm:ss');//获取今日时间
$(function() {
	$("#edit_createTime").val(createDate);
	//绑定提交按钮click事件
	$("#submit").click(function() {
		$("#submit").prop('disabled', true).css({'cursor':'not-allowed'});
		showMessage("正在处理，请稍后...");
		if(!biz.validate("valid",$('#empTableGrantFormEdit')[0])){
			showWarn("数据验证失败",3000);
			$("#submit").prop('disabled', false).css({'cursor':'pointer'});
			return;
		}
		var options = {
			url : "<m:url value='/empTableGrant/updateEmpTableGrant.do'/>",
			type : "post",
				dataType:"json",
				success : function(d) {
					if(d.status){
						showMessage(d.message,"","",function(){
							window.parent.closeEdit();
				     		window.parent.doSearch();
						});
					}else{
						showMessage(d.message);
					}
				}
		};
		// 将options传给ajaxForm
		$('#empTableGrantFormEdit').ajaxSubmit(options);
	});
	/*补助日期起格式化*/
	new biz.datepicker({
		id : "#edit_grantDateStart",
		dateFmt:'yyyy-MM-dd',
		maxDate:'%y-%M-%d'
	});
	
	/*补助日期止格式化*/
	new biz.datepicker({
		id : "#edit_grantDateEnd",
		dateFmt:'yyyy-MM-dd',
		maxDate:'%y-%M-%d'
	});
	/*编辑表单数据验证*/
	new biz.validate({
		id:"#empTableGrantFormEdit",
		rules:{
			"reason" :{required : true},
			"grantTime" :{required : true},
		}
	}); 
});
function countGrantTime(){
	var start = $("#edit_grantDateStart").val();
	var end = $("#edit_grantDateEnd").val();
	if(start.length>0&&end.length>0){
		var sArr = start.split("-");
		var eArr = end.split("-");
		var sRDate = new Date(sArr[0], sArr[1], sArr[2]);
		var eRDate = new Date(eArr[0], eArr[1], eArr[2]);
		var grantTime = (eRDate-sRDate)/(24*60*60*1000)+1;
		$("#edit_grantTime").val(grantTime);
		$("#edit_tableMoney").val(grantTime*10);
	}
}
</script>
</head>

<body>
	<form id="empTableGrantFormEdit">
		<div class="wrap">
			<input type="hidden" id="edit_id" name="id" type="text"
				value="${empTableGrant.id}" />
			<div class="top_head">
				<h2 class="top_name">餐补申请</h2>
				<div class="time_bg"
					style="top: 40px; left: 0px; height: 25px; line-height: 25px; position: absolute; width: 220px">
					<span>申请时间：</span> <input id="edit_createTime" name="createTime"
						class="input_select" style="height: 25px; width: 100px" readonly />
					<i class="search_time_ico2" style="top: 6px;"></i>
				</div>
			</div>

			<div class="center_body">
				<table class="table">
					<tr>
						<td class="inputLabelTd"><span class="required">*</span>所属部门：</td>
						<td class="inputTd"><input id="edit_deptName" name="deptName"
							type="text" class="text" value="${user.dept}" readonly /></td>
						<td class="inputLabelTd"><span class="required">*</span>申请人：</td>
						<td class="inputTd"><input id="edit_empId" name="empId"
							type="hidden" class="text" value="${user.id}" readonly /> <input
							id="edit_enterName" name="enterName" type="text" class="text"
							value="${user.nickName}" readonly /></td>
					</tr>
					<tr class="trDetails" style="height: 140px;">
						<td class="inputLabelTd"><span class="required">*</span>申请理由：</td>
						<td class="inputTd" colspan="3"><textarea class="text"
								name="reason" id="edit_reason"></textarea></td>
					</tr>
					<tr>
						<td class="inputLabelTd">补助日期日起：</td>
						<td class="inputTd">
							<div class="time_bg" style="width: 98%;">
								<input id="edit_grantDateStart" name="grantDateStart"
									type="text" class="text"
									value="${empTableGrant.grantDateStart}"
									onchange="countGrantTime()" />
							</div>
						</td>
						<td class="inputLabelTd">补助日期日止：</td>
						<td class="inputTd">
							<div class="time_bg" style="width: 98%;">
								<input id="edit_grantDateEnd" name="grantDateEnd" type="text"
									class="text" value="${empTableGrant.grantDateEnd}"
									onchange="countGrantTime()" />
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
							value="${empTableGrant.tableMoney}" /></td>
					</tr>
					<tr>
						<td class="inputLabelTd"><span class="required">*</span>部门经理：
						</td>
						<td class="inputTd"><input id="edit_deptLeader"
							name="deptLeader" type="text" class="text"
							value="${user.deptLeader}" readonly /></td>
					</tr>
				</table>
				<div class="inputTd" style="display: block; text-align: center;">
					<input id="submit" type="button" class="ti_bottom" value="提交修改" />
				</div>
			</div>
		</div>

	</form>
</body>
</html>
