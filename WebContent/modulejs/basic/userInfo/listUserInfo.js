var gridObj = {};
var orgId, orgName;
var areaProvinceBox, areaRegionBox, areaCityBox;
$(function() {
	initOrgTree();
	gridObj = new biz.grid({
		id : "#remote_rowed",/* html部分table id */
		url : baseUrl + "/userInfo/listUserInfo.do",/* grid初始化请求数据的远程地址 */
		datatype : "json",/* 数据类型，设置为json数据，默认为json */
		sortname : "created",
		sortorder : "asc",
		// navtype:"top" /*导航栏类型*/,
		// height: gridHeight,
		pager : '#remote_prowed' /* 分页栏id */,
		rowList : [ 10, 20, 30, 50, 100, 200 ],// 每页显示记录数
		rowNum : 10,// 默认显示15条
		shrinkToFit:false,
		singleselect : true,
		colModel : [ {
			name : "userId",
			hidden : true,
			key : true
		}, {width : 100,
			name : "userAccount",
			label : "登录账号",
			index : "USER_ACCOUNT"
		}, {width : 100,
			name : "fullName",
			label : "用户姓名",
			index : "full_Name"
		}, {width : 100,
			name : "orgName",
			label : "部门单位",
			index : "ORG_ID"
		}, {width : 50,
			name : "sex",
			label : "性别",
			formatter:function(cellvalue, options, rowObject){
				 if (cellvalue==1) {
				 	return '男';
				 }else {
				 	return '女';
				 }
			}
		}, 
		 {width : 50,
			name : "age",
			label : "年龄"
		},{width : 100,
			name : "mobilePhone",
			label : "手机号码",
			index:"MOBILE_PHONE"
		},{width : 100,
			name : "areaProvinceName",
			label : "省",
			index:"AREA_PROVINCE_ID"
		},{width : 100,
			name : "areaRegionName",
			label : "市州",
			index:"AREA_REGION_ID"
		},{width : 100,
			name : "areaCityName",
			label : "县区",
			index:"AREA_CITY_ID"
		},{width : 100,
			name : "lastLoginIp",
			label : "最后登录IP",
			index : "LAST_LOGIN_IP"
		}, {width : 50,
			name : "states",
			label : "状态",
			formatter:GridColModelForMatter.enableStates
		}, {width : 150,
			name : "created",
			label : "创建时间"
		}, {width : 150,
			name : "lastLoginTime",
			label : "最后登录时间",
			index : "LAST_LOGIN_TIME"
		}],
		serializeGridData : function(postData) {// 添加查询条件值
			var obj = getQueryCondition();
			$.extend(true, obj, postData);// 合并查询条件值与grid的默认传递参数
			return obj;
		}
	});


	//省
	areaProvinceBox = $('#areaProvinceName').TiledCombobox({
		url :  baseUrl +"/areaProvince/list.do",
		fieldId : 'aapid',
		fieldName : 'provinceName',
		valueId : '#areaProvinceId',
		multiple : false,
		onChangeFn : function(v) {
			areaRegionBox.setQueryDataAndReload("apid=" + v);
			areaRegionBox.clearVlaue();
			areaCityBox.clearVlaue();
		}
	});
	//市
	areaRegionBox = $('#areaRegionName').TiledCombobox({
		url :  baseUrl +"/areaRegion/list.do",
		fieldId : 'aarid',// 数据有几级
		fieldName : 'regionName',
		valueId : '#areaRegionId',
		multiple : false,
		autoLoadData:false,
		onChangeFn : function(v) {
			areaCityBox.setQueryDataAndReload("aarid=" + v);
			areaCityBox.clearVlaue();
		}
	});
	//县区市
	areaCityBox = $('#areaCityName').TiledCombobox({
		url :  baseUrl +"/areaCity/list.do",
		fieldId : 'aacid',// 数据有几级
		fieldName : 'cityName',
		valueId : '#areaCityId',
		autoLoadData:false,
		multiple : false
	});
});

/**
 * 获取查询条件值
 */
function getQueryCondition() {
	var obj = {};
	addAttrToObject(obj, "orgId");
	addAttrToObject(obj, "userAccount");
	addAttrToObject(obj, "fullName");
	addAttrToObject(obj, "mobilePhone");
	addAttrToObject(obj, "idCard");
	addAttrToObject(obj, "orgClass");
	addAttrToObject(obj, "areaProvinceId");
	addAttrToObject(obj, "areaRegionId");
	addAttrToObject(obj, "areaCityId");
	return obj;
}

// 新增的弹出框
var add_iframe_dialog;
// 修改的弹出框
var edit_iframe_dialog;
// 查看的弹出框
var show_iframe_dialog;

function add() {
	// xin zeng iframe 弹出框
	if (orgId == null || orgId == '') {
		showMessage('请选择一个组织机构');
		return;
	}
	var url = baseUrl + '/userInfo/toAddUserInfo.do?orgId='+orgId;
	add_iframe_dialog = new biz.dialog(
			{
				id : $('<div id="addwindow_iframe"></div>')
						.html(
								'<iframe id="iframeAdd" name="iframeAdd" src="'
										+ url
										+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
				modal : true,
				width : 800,
				height : 500,
				title : "用户信息增加"
			});
	add_iframe_dialog.open();
	//window.location.href=url; 
}

// 关闭新增页面，供子页面调用
function closeAdd() {
	add_iframe_dialog.close();
}

function edit() {
	var key = ICSS.utils.getSelectRowData("userId");
	if (key.indexOf(",") > -1 || key == "") {
		showMessage("请选择一条数据！");
		return;
	}
	var url = baseUrl + '/userInfo/toEditUserInfo.do?key=' + key;
	edit_iframe_dialog = new biz.dialog(
			{
				id : $('<div id="editwindow_iframe"></div>')
						.html(
								'<iframe id="iframeEdit" name="iframeEdit" src="'
										+ url
										+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
				modal : true,
				width : 800,
				height : 500,
				title : "用户信息编辑"
			});
	edit_iframe_dialog.open();
}

// 关闭编辑页面，供子页面调用
function closeEdit() {
	edit_iframe_dialog.close();
}

function show() {
	var key = ICSS.utils.getSelectRowData("userId");
	if (key.indexOf(",") > -1 || key == "") {
		showMessage("请选择一条数据！");
		return;
	}
	var url = baseUrl + '/userInfo/toShowUserInfo.do?key=' + key;
	show_iframe_dialog = new biz.dialog(
			{
				id : $('<div id="showwindow_iframe"></div>')
						.html(
								'<iframe id="iframeShow" name="iframeShow" src="'
										+ url
										+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
				modal : true,
				width : 800,
				height : 500,
				title : "用户信息详情"
			});
	show_iframe_dialog.open();
}

// 关闭查看页面，供子页面调用
function closeShow() {
	show_iframe_dialog.close();
}

// 查询Grid数据
function doSearch(isStayCurrentPage) {
	if (!isStayCurrentPage)
		gridObj.setGridParam({
			"page" : "1"
		});
	gridObj.trigger('reloadGrid');
}
// 重置查询表单
function resetForm(formId) {
	document.getElementById(formId).reset();
	$("#"+formId+" input[type='hidden']").val(""); 
	$(".selected").removeClass("selected");//清除选中
	initOrgTree();
	doSearch();
}

// 删除
function batchDelete() {
	var ids = ICSS.utils.getSelectRowData("userId");
	if (ids == "") {
		showMessage("请至少选择一条数据！");
		return;
	} else {
		new biz.alert({
			type : "confirm",
			message : I18N.msg_del_confirm,
			title : I18N.promp,
			callback : function(result) {
				if (result) {
					$.ajax({
						url : baseUrl + '/userInfo/deleteUserInfo.do?key='
								+ ids,
						cache : false,
						dataType : 'json',
						success : function(d, textStatus, jqXHR) {
							doSearch();
							showInfo(d.msg || d.message, 3000);
						}
					});
				}
			}
		});
	}
}
function initOrgTree() {
	$.ajax({
		url : baseUrl + "/org/initOrgTree.do",
		data : {
		// regionName : $('#regionName').val(),
		// provinceName : $('#provinceName').val()
		},
		type : "POST",
		dataType:"json",
		success : function(data, textStatus, jqXHR) {
			var setting_checkbox = {
				data : {},
				id : "#orgTree",
				nodes :data, // 数据节点指定
				data : {
					simpleData : {
						enable : true
					}
				},
				callback : {
					onClick : treeOnClick
				}
			};
			provinceTree = new biz.tree(setting_checkbox);// 创建树
		}
	});
}
function treeOnClick(event, treeId, treeNode) {//
// if(treeNode.isParent){
// $("#apid").val(treeNode.id);
	$("#orgId").val(treeNode.id);
	orgId = treeNode.id;
	orgName = treeNode.name;
	doSearch();
	// }else{
	// $("#apid").val(treeNode.pId);
	// $("#aarid").val(treeNode.id);
	// doSearch();
	// }
}

function expExcelWinShow(){
	ExpExcel.showWin(gridObj,baseUrl+"/userInfo/exportExcel.do",'grid','queryForm');
	}