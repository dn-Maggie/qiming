<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<%@ include file="../../common/header.jsp"%>
<title></title>
<script type="text/javascript">
var gridObj = {};
	$(function(){
  		gridObj = new biz.grid({
            id:"#remote_rowed",/*html部分table id*/
            url: "<m:url value='/empTableGrant/listEmpTableGrant.do'/>",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"create_time",
           	sortorder:"desc",
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
            colModel:[
				{name : "id",hidden : true,key : true,label:"主键",index : "id"},				
				{name : "empId",hidden : true},
				{name : "empDept",label:"所属部门",index : "empDept"},
				{name : "empNickName",label:"申请员工",index : "empNickName"},				
				{name : "createTime",label:"申请日期",index : "create_time"},				
				{name : "reason",label:"申请理由",index : "reason"},
				{name : "grantTime",label:"补助次数",index : "grant_time"},				
				{name : "tableMoney",label:"餐补合计",index : "table_money"},				
				{name : "checkName",label:"审核人",index : "checkName"},				
				{name : "checkDate",label:"审核日期",index : "check_date"}				
           	],
           	serializeGridData:function(postData){//添加查询条件值
				var obj = getQueryCondition();
    			$ .extend(true,obj,postData);//合并查询条件值与grid的默认传递参数
    			return obj;
    		}
      });
        
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
  	//xin zeng iframe 弹出框
		var url="<m:url value='/empTableGrant/toAddEmpTableGrant.do'/>";
		add_iframe_dialog = new biz.dialog({
			id:$('<div id="addwindow_iframe"></div>').html('<iframe id="iframeAdd" name="iframeAdd" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.6,
			height:$(window).height()*0.5,
			title: "员工晚餐补助申请表"
		});
		add_iframe_dialog.open();
  	}
  	
  	//关闭新增页面，供子页面调用
  	function closeAdd(){
		add_iframe_dialog.close();
  	}
  	
    function edit(){
		var key = ICSS.utils.getSelectRowData("id");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var checkName = ICSS.utils.getSelectRowData("checkName");
		if(checkName!=""){
			showMessage("该数据已审核不能被修改");
			return ;
		}
		var empId = ICSS.utils.getSelectRowData("empId");
		if(empId!=$("#userId").val()){
			showMessage("无法修改他人数据！");
			return ;
		}
		var url="<m:url value='/empTableGrant/toEditEmpTableGrant.do'/>?key="+key;
		edit_iframe_dialog = new biz.dialog({
		 	id:$('<div id="editwindow_iframe"></div>').html('<iframe id="iframeEdit" name="iframeEdit" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.6,
			height:$(window).height()*0.5,
			title: "员工晚餐补助申请表"
		});
  		edit_iframe_dialog.open();
    }
    
    //关闭编辑页面，供子页面调用
    function closeEdit(){
    	edit_iframe_dialog.close();
    }
    
    function show(){
    	var key = ICSS.utils.getSelectRowData("id");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var url="<m:url value='/empTableGrant/toShowEmpTableGrant.do'/>?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: $(window).width()*0.6,
			height:$(window).height()*0.5,
				title: "员工晚餐补助申请表"
		});
  		show_iframe_dialog.open();
    }
    
    //关闭查看页面，供子页面调用
    function closeShow(){
    	show_iframe_dialog.close();
    }
    
  //审核方法
    function audit(){
    	var key = ICSS.utils.getSelectRowData("id");
    	var empId = ICSS.utils.getSelectRowData("empId");
    	if(key==""){
    		showMessage("请至少选择一条数据！");
    		return;
    	}
    	if(empId.indexOf($("#userId").val())>-1){
			showMessage("无法审核自己的申请！");
			return;
		}
    	else{
    		new biz.alert({type:"confirm",message:"确定审核数据？",title:I18N.promp,callback:function(result){
    			if(result){
    				$ .ajax({
        				url: "<m:url value='/empTableGrant/auditEmpTableGrant.do'/>?key="+key,
        				cache:false,
        				success: function(data, textStatus, jqXHR){
        					doSearch();
    						showInfo("审核成功",3000);
        				}
        			});
    			}
    		}}) ;   
    	}
    }
  
    /**
    * 获取查询条件值
    */
    function getQueryCondition(){
       var obj = {};
		jQuery.each($("#queryForm").serializeArray(),function(i,o){
        	if(o.value){
        		obj[o.name] = o.value;
        	}
        });
		return obj;
    }
    //查询Grid数据
    function doSearch(isStayCurrentPage){
    	if(!isStayCurrentPage)gridObj.setGridParam({"page":"1"});
    	gridObj.trigger('reloadGrid');
    }
    //重置查询表单
    function resetForm(formId){
		document.getElementById(formId).reset();
	}
    
    //删除
    function batchDelete(){
    	var ids = ICSS.utils.getSelectRowData("id");
    	var empId = ICSS.utils.getSelectRowData("empId");
    	var checkName = ICSS.utils.getSelectRowData("checkName");
    	if(ids==""){
    		showMessage("请至少选择一条数据！");
    		return ;
    	}
    	if(checkName.indexOf("")>-1){
   			showMessage("选项中包含已审核的数据，请重新选择");
   			return;
   		}
    	else{
    		new biz.alert({type:"confirm",message:I18N.msg_del_confirm,title:I18N.promp,callback:function(result){
    			if(result){
    				$ .ajax({
        				url: "<m:url value='/empTableGrant/deleteEmpTableGrant.do'/>?key="+ids,
        				cache:false,
        				success: function(data, textStatus, jqXHR){
        					doSearch();
    						showInfo("删除成功",3000);
        				}
        			});
    			}
    		}}) ;   
    	}
    }
    </script>
</head>
<body style="height: 100%;">
	<div class="main  choice_box">
		<form id="queryForm">
			<!-- 查询区 表单 -->
			<input type="hidden" name="userId" id="userId" value="${user.id}">
			<c:if test="${common&&!deptLeader&&!headLeader}">
				<input type="hidden" name="empId" id="empId" value="${user.id}">
			</c:if>
			<div class="search border-bottom">
				<ul>
					<li class="date_area"><span>申请日期:</span>
						<div class="time_bg">
							<input id="startDate" type="text" class="search_time150"
								name="propsMap['startDate']" mainid="startDate"> <i
								class="search_time_ico2" onclick="WdatePicker({el:'startDate'})"></i>
						</div> <i>至</i>
						<div class="time_bg">
							<input id="endDate" type="text" class="search_time150"
								name="propsMap['endDate']" mainid="endDate"> <i
								class="search_time_ico2" onclick="WdatePicker({el:'endDate'})"></i>
						</div></li>
					<li><input type="reset" class="reset_btn"
						onclick="resetForm('queryForm')" value="重置">
					<!-- 重置 --> <input type="button" class="search_btn mr22 "
						onclick="doSearch();" value="查询"></li>
					<!-- 查询-->
				</ul>
			</div>
		</form>
		<div class="listplace">
			<!--功能按钮begin-->
			<div class="list_btn_bg fl">
				<!--功能按钮 div-->
				<ul>
					<c:if test="${add}">
						<li><a title="申请" href="javascript:;" onclick="add();"> <i
								class="icon_bg icon_add"> </i> <span>申请</span>
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
					<c:if test="${deptLeader||headLeader||!isNotAdmin}">
						<li><a title="审核" href="javascript:" onclick="audit();">
								<i class="icon_bg icon_audit"></i> <span>审核</span>
						</a></li>
					</c:if>
					<c:if test="${manage}">
						<li><a title="<m:message code="button.module.moduleRes"/>"
							href="javascript:" onclick="moduleResMgt();"> <i
								class="back_icon resources_icon"></i> <span><m:message
										code="button.module.moduleRes" /></span>
						</a></li>
					</c:if>
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
