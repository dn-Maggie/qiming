var gridObj = {};
$(function() {
	initprovinceTree();
	gridObj = new biz.grid({
		id : "#remote_rowed",/* html部分table id */
		url : baseUrl + "/areaRegion/listAreaRegion.do",/* grid初始化请求数据的远程地址 */
		datatype : "json",/* 数据类型，设置为json数据，默认为json */
		sortname : "t.aarid",
		sortorder : "asc",
		// navtype:"top" /*导航栏类型*/,
		// height: gridHeight,
		pager : '#remote_prowed' /* 分页栏id */,
		rowList : [ 10, 15, 50, 100 ],// 每页显示记录数
		rowNum : 10,// 默认显示15条
		colModel : [ {
			name : "aarid",
			label : "地区编码",
			index : "t.aarid"
		}, {
			name : "regionName",
			label : "地区名称",
			index : "t.REGION_NAME"
		}, {
			name : "apid",
			label : "省编码",
			index : "t.apid"
		}, {
			name : "apName",
			label : "省名称",
			index : "t.apid"
		}, {
			name : "aacid",
			label : "中心城市编码",
			index : "t.aacid"
		}, {
			name : "aacName",
			label : "中心城市名称",
			index : "t.aacid"
		}, {
			name : "spy",
			label : "简拼音",
			index : "t.spy"
		}, {
			name : "population",
			label : "人口数量",
			index : "t.population"
		} ],
		serializeGridData : function(postData) {// 添加查询条件值
			var obj = getQueryCondition();
			$.extend(true, obj, postData);// 合并查询条件值与grid的默认传递参数
			return obj;
		}
	});

});

/**
 * 获取查询条件值
 */
function getQueryCondition() {
	var obj = {};
	addAttrToObject(obj, "apid");
	addAttrToObject(obj, "aarid");
	addAttrToObject(obj, "regionName");
	addAttrToObject(obj, "spy");
	return obj;
}

// 新增的弹出框
var add_iframe_dialog;
// 修改的弹出框
var edit_iframe_dialog;
// 查看的弹出框
var show_iframe_dialog;

function add() {
	var apid = $("#apid").val();
	if (apid == null || apid == 0) {
		showMessage("请选择一个省份");
		return;
	}
	var url = baseUrl + "/areaRegion/toAddAreaRegion.do?apid=" + apid;
	add_iframe_dialog = new biz.dialog(
			{
				id : $('<div id="addwindow_iframe"></div>')
						.html(
								'<iframe id="iframeAdd" name="iframeAdd" src="'
										+ url
										+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
				modal : true,
				width : 600,
				height : 255,
				title : "市数据增加"
			});
	add_iframe_dialog.open();
}

// 关闭新增页面，供子页面调用
function closeAdd() {
	add_iframe_dialog.close();
}

function edit() {
	var key = ICSS.utils.getSelectRowData("aarid");
	if (key.indexOf(",") > -1 || key == "") {
		showMessage("请选择一条数据！");
		return;
	}
	var url = baseUrl + "/areaRegion/toEditAreaRegion.do?key=" + key;
	edit_iframe_dialog = new biz.dialog(
			{
				id : $('<div id="editwindow_iframe"></div>')
						.html(
								'<iframe id="iframeEdit" name="iframeEdit" src="'
										+ url
										+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
				modal : true,
				width : 600,
				height : 255,
				title : "市数据编辑"
			});
	edit_iframe_dialog.open();
}

// 关闭编辑页面，供子页面调用
function closeEdit() {
	edit_iframe_dialog.close();
}

function show() {
	var key = ICSS.utils.getSelectRowData("aarid");
	if (key.indexOf(",") > -1 || key == "") {
		showMessage("请选择一条数据！");
		return;
	}
	var url = baseUrl + "/areaRegion/toShowAreaRegion.do?key=" + key;
	show_iframe_dialog = new biz.dialog(
			{
				id : $('<div id="showwindow_iframe"></div>')
						.html(
								'<iframe id="iframeShow" name="iframeShow" src="'
										+ url
										+ '" width="100%" frameborder="no" border="0" height="97%"></iframe>'),
				modal : true,
				width : 600,
				height : 255,
				title : "市数据详情"
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
	doSearch();
}

// 删除
function batchDelete() {
	var ids = ICSS.utils.getSelectRowData("aarid");
	if (ids.indexOf(",") > -1 || ids == "") {
		showMessage("请选择一条数据！");
		return;
	} else {
		new biz.alert({
			type : "confirm",
			message : I18N.msg_del_confirm,
			title : I18N.promp,
			callback : function(result) {
				if (result) {
					$.ajax({
						url : baseUrl + "/areaRegion/deleteAreaRegion.do?key="
								+ ids,
						cache : false,
						success : function(data, textStatus, jqXHR) {
							var d = $.parseJSON(data);
							if (d.status == 1) {
								showMessage(d.message, "", "", function() {
									doSearch();
								});
							} else {
								showMessage(d.message);
							}
						}
					});
				}
			}
		});
	}
}

function initprovinceTree() {
	$.ajax({
		url : baseUrl + "/areaProvince/initAreaTree.do",
		data : {
			provinceName : $('#provinceName').val()
		},
		type : "POST",
		success : function(data, textStatus, jqXHR) {
			var setting_checkbox = {
				id : "#provinceTree",
				nodes : $.parseJSON(data), // 数据节点指定
				view : {
					// addHoverDom : addHoverDom,
					// removeHoverDom : removeHoverDom,
					selectedMulti : false
				},
				edit : {
				// enable : true,
				// editNameSelectAll : true
				},
				data : {
					simpleData : {
						enable : true
					}
				},
				callback : {
					// beforeEditName : beforeEditName,
					// beforeRemove : beforeRemove,
					onClick : treeOnClick
				}
			};
			provinceTree = new biz.tree(setting_checkbox);// 创建树
		}
	});
}
function treeOnClick(event, treeId, treeNode) {//
	$("#apid").val(treeNode.id == "0" ? "" : treeNode.id);
	doSearch();
}
