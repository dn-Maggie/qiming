
var gridObj = {};
$(function() {
	gridObj = new biz.grid({
		id : "#remote_rowed",/* html部分table id */
		url : baseUrl + '/module/listModule.do',/* grid初始化请求数据的远程地址 */
		datatype : "json",/* 数据类型，设置为json数据，默认为json */
		sortname : "SERIAL_INDEX",
		sortorder : "asc",
		pager : '#remote_prowed' /* 分页栏id */,
		rowList : [ 10, 15, 50, 100 ],// 每页显示记录数
		rowNum : 10,// 默认显示15条
		rownumbers : true, // 是否显示行号
		colModel : [ {
			name : "id",
			hidden : true,
			key : true
		}, {
			name : "moduleName",
			label : "菜单名称",
			index : "MODULE_NAME"
		}, {
			name : "moduleCode",
			label : "菜单编码",
			index : "MODULE_CODE"
		}, {
			name : "navurl",
			label : "导航URL",
			index : "NAVURL"
		}, {
			name : "serialIndex",
			label : "顺序",
			align : "center",
			width : 40,
			index : "SERIAL_INDEX"
		}, {
			name : "enabled",
			label : "状态",
			formatter : ma_status,
			align : "center",
			width : 40,
			index : "ENABLED"
		}, {
			name : "needRight",
			label : "是否需求权限",
			formatter : ma_needright,
			align : "center",
			width : 50,
			index : "NEED_RIGHT"
		}, {
			name : "moduleMemo",
			label : "备注",
			sortable : false
		} ],
		serializeGridData : function(postData) {// 添加查询条件值
			var obj = getQueryCondition();
			$.extend(true, obj, postData);// 合并查询条件值与grid的默认传递参数
			return obj;
		},
		gridComplete : function() {
			// 数据加载完毕后，调整样式
			var ids = gridObj.getDataIDs();
			if (ids == "") {
				$("#next_remote_prowed").attr("class",
						"ui-pg-button ui-corner-all ui-state-disabled");
				$("#last_remote_prowed").attr("class",
						"ui-pg-button ui-corner-all ui-state-disabled");
			}
		}
	});
});

function ma_status(cellvalue, options, rowObject) {
	if (cellvalue == '1') {
		return "启用";
	} else if (cellvalue == '0') {
		return "禁用";
	}
}

function ma_needright(cellvalue, options, rowObject) {
	if (cellvalue == '1') {
		return "是";
	} else if (cellvalue == '0') {
		return "否";
	}
}

/**
 * 获取查询条件值
 */
function getQueryCondition() {
	var obj = {};
	addAttrToObject(obj, "moduleName");
	addAttrToObject(obj, "moduleCode");
	addAttrToObject(obj, "enabled");
	addAttrToObject(obj, "needRight");
	return obj;
}

function addAttrToObject(obj, name) {
	element = document.getElementById(name);
	var notInputValue = "";
	if (element != null) {
		if (element.value == null || element.value == "") {
			if ($(element).attr("uiType") != null) {
				if ($(element).attr("uiType") == "checkbox") {
					var tempCheckBoxObj = $(element).find(".checkbox");
					if (tempCheckBoxObj != null && tempCheckBoxObj.length > 0) {
						tempCheckBoxObj.each(function() {
							if (this.checked) {
								notInputValue += this.value + ",";
							}
						});
						if (notInputValue != null
								&& notInputValue.indexOf(",") != -1) {
							notInputValue = notInputValue.substring(0,
									notInputValue.length - 1);
						}

					}
				} else if ($(element).attr("uiType") == "radio") {
					var tempRadioObj = $(element).find(".radio");
					if (tempRadioObj != null && tempRadioObj.length > 0) {
						tempRadioObj.each(function() {
							if (this.checked) {
								notInputValue = this.value;
								return;
							}
						});
					}
				}
				if (notInputValue == null || notInputValue == "") {
					return;
				}
			} else {
				return;
			}
		}

	} else {
		return;
	}

	obj = obj || {};
	var value = element.value != null ? element.value : notInputValue;
	if (element.name == 'moduleName') {
		value = '%' + value + '%';
	}
	if (element.name == 'moduleCode') {
		value = '%' + value + '%';
	}
	obj[name] = value;
}

// 新增的弹出框
var add_iframe_dialog;
// 修改的弹出框
var edit_iframe_dialog;
// 查看的弹出框
var show_iframe_dialog;

function add() {
	// xin zeng iframe 弹出框
	var url = baseUrl + '/module/toAddModule.do';
	add_iframe_dialog = new biz.dialog(
			{
				id : $('<div id="addwindow_iframe"></div>')
						.html(
								'<iframe id="iframeAdd" name="iframeAdd" src="'
										+ url
										+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
				modal : true,
				width : 600,
				height : 300,
				title : "添加菜单信息"
			});
	add_iframe_dialog.open();
}

// 关闭新增页面，供子页面调用
function closeAdd() {
	add_iframe_dialog.close();
}

function edit() {
	var key = ICSS.utils.getSelectRowData("id");
	if (key.indexOf(",") > -1 || key == "") {
		showMessage("请选择一条数据");
		return;
	}
	var url = baseUrl + '/module/toUpdateModule.do?key=' + key;
	edit_iframe_dialog = new biz.dialog(
			{
				id : $('<div id="editwindow_iframe"></div>')
						.html(
								'<iframe id="iframeEdit" name="iframeEdit" src="'
										+ url
										+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
				modal : true,
				width : 600,
				height : 300,
				title : "编辑菜单信息"
			});
	edit_iframe_dialog.open();
}

// 关闭编辑页面，供子页面调用
function closeEdit() {
	edit_iframe_dialog.close();
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
	doSearch();
}

// 删除
function batchDelete() {
	var ids = ICSS.utils.getSelectRowData("id");
	if (ids == "") {
		showMessage("请选择一条数据");
		return;
	} else {
		new biz.alert({
			type : "confirm",
			message : I18N.msg_del_confirm,
			title : I18N.promp,
			callback : function(result) {
				if (result) {
					$.ajax({
						url : baseUrl + '/module/deleteModule.do?key=' + ids,
						cache : false,
						success : function(data, textStatus, jqXHR) {
							doSearch();
							showInfo("删除成功", 3000);
						}
					});
				}
			}
		});
	}
}
// 打开菜单资源管理界面
function moduleResMgt() {
	var key = ICSS.utils.getSelectRowData("id");
	if (key.indexOf(",") > -1 || key == "") {
		showMessage("请选择一条数据");
		return;
	}
	var url = baseUrl + '/module/toListModuleRes.do?key=' + key;
	moduleReslist_iframe_dialog = new biz.dialog(
			{
				id : $('<div id="sublist_window_iframe"></div>')
						.html(
								'<iframe id="iframeSublist" name="iframeSublist" src="'
										+ url
										+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
				modal : true,
				width : 850,
				height : 450,
				title : "菜单资源管理"
			});
	moduleReslist_iframe_dialog.open();
}

// 关闭关联资源管理界面
function closeModuleRes() {
	moduleReslist_iframe_dialog.close();
}