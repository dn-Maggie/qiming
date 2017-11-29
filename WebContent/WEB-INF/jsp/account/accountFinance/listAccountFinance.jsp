<%@page import="com.dongnao.workbench.common.enums.FinanceType"%>
<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML  >
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title></title>
<script type="text/javascript">
var gridObj = {};
var Model = {
		url: "<m:url value='/accountFinance/listAccountFinance.do'/>",
		colModel:[
					{name : "id",hidden : true,key : true,label:"财务科目id",index : "id"},				
					{name : "accountNo",label:"科目编号",index : "account_no"},				
					{name : "accountName",label:"科目名称",index : "account_name"},				
					{name : "accountType",label:"科目类型",index : "account_type",formatter:GridColModelForMatter.finance_type},				
					{name : "intro",label:"科目说明",index : "intro"}				
	           	]
		};
	$(function(){
  		gridObj = List.createGrid(Model.url,Model.colModel,"id", false);
		new biz.datepicker({
  			id : "#startDate",
  			maxDate:'#F{$dp.$D(\'endDate\',{d:0});}',
  			dateFmt:'yyyy-MM-dd'
  		});
  	    new biz.datepicker({
  			id : "#endDate",
  			minDate:'#F{$dp.$D(\'startDate\',{d:0});}',
  			dateFmt:'yyyy-MM-dd'
  		});
    });

    //新增的弹出框
	var add_iframe_dialog;
	//修改的弹出框
   	var edit_iframe_dialog;
	//查看的弹出框
	var show_iframe_dialog;
  	
  	function add(){
  		var url = "<m:url value='/accountFinance/toAddAccountFinance.do'/>";
		var title = "财务科目增加";
		add_iframe_dialog = Add.create(url, title,800,235);
		List.openDialog(add_iframe_dialog);
  	}
  	
  	//关闭新增页面，供子页面调用
  	function closeAdd(){
  		List.closeDialog(add_iframe_dialog,gridObj);
  	}
  	
    function edit(){
    	var key = ICSS.utils.getSelectRowData("id");
		var url = "<m:url value='/accountFinance/toEditAccountFinance.do'/>";
		var title = "财务科目编辑";
		edit_iframe_dialog = Edit.create(key, url, title,800,255);
		List.openDialog(edit_iframe_dialog);
    }
    
    //关闭编辑页面，供子页面调用
    function closeEdit(){
		List.closeDialog(edit_iframe_dialog,gridObj);
    }
    
    function show(){
    	var key = ICSS.utils.getSelectRowData("id");
		var url = "<m:url value='/accountFinance/toShowAccountFinance.do'/>";
		var title = "财务科目详情";
		show_iframe_dialog = Show.create(key, url, title,800,235);
		List.openDialog(show_iframe_dialog);
    }
    
    //关闭查看页面，供子页面调用
    function closeShow(){
    	List.closeDialog(show_iframe_dialog);
    }
    //删除
    function batchDelete(){
    	var id = ICSS.utils.getSelectRowData("id");
		var url = "<m:url value='/accountFinance/deleteAccountFinance.do'/>";
		List.batchDelete(id, url,gridObj);
    }
    </script>
</head>
<body style="height: 100%;">
	<div class="main  choice_box">
		<form id="queryForm">
			<!-- 查询区 表单 -->
			<div class="search border-bottom">
				<ul>
					<li><input type="text" name="accountName" id="accountName"
						class="search_choose"> <span>科目名称:</span></li>
					<li><select class="search_select" name="accountType"
						id="accountType">
							<option value="">--请选择--</option>
							<c:forEach items="<%=FinanceType.values()%>" var="status">
								<option value="${status.value }">${status.name }</option>
							</c:forEach>
					</select> <span>科目类型:</span></li>
					<li><input type="reset" class="reset_btn"
						onclick="List.resetForm('queryForm')" value="重置">
					<!-- 重置 --> <input type="button" class="search_btn mr22 "
						onclick="List.doSearch(gridObj);" value="查询">
					<!-- 查询--></li>
				</ul>
			</div>
		</form>
		<div class="listplace">
			<!--功能按钮begin-->
			<div class="list_btn_bg fl">
				<!--功能按钮 div-->
				<ul>
					<c:if test="${add}">
						<li><a title="<m:message code="button.add"/>"
							href="javascript:;" onclick="add();"> <i
								class="icon_bg icon_add"> </i> <span><m:message
										code="button.add" /></span>
						</a></li>
					</c:if>
					<c:if test="${edit}">
						<li><a title="<m:message code="button.edit"/>"
							href="javascript:;" onclick="edit();"><i
								class="icon_bg icon_edit"></i> <span><m:message
										code="button.edit" /></span> </a></li>
					</c:if>
					<c:if test="${delete}">
						<li><a title="<m:message code="button.delete"/>"
							href="javascript:;" onclick="batchDelete();"> <i
								class="icon_bg icon_del"></i> <span><m:message
										code="button.delete" /></span>
						</a></li>
					</c:if>
					<li><a title="<m:message code="button.view"/>"
						href="javascript:" onclick="show();"> <i
							class="icon_bg icon_ckxq"></i> <span><m:message
									code="button.view" /></span>
					</a></li>
				</ul>
			</div>

			<!--功能按钮end-->
			<div class="listtable_box">
				<!--此处放表格-->
				<table id="remote_rowed"></table>
				<div id="remote_prowed"></div>
			</div>
		</div>
	</div>
</body>
</html>
