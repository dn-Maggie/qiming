var gridObj = {};
	$(function(){
		initprovinceTree();
  		gridObj = new biz.grid({
            id:"#remote_rowed",/*html部分table id*/
            url: baseUrl+"/areaCity/listAreaCity.do",/*grid初始化请求数据的远程地址*/
            datatype: "json",/*数据类型，设置为json数据，默认为json*/
           	sortname:"SERIAL_INDEX", 
           	sortorder:"asc",
           	//navtype:"top" /*导航栏类型*/,
           	//height: gridHeight,
           	pager: '#remote_prowed' /*分页栏id*/,
     		rowList:[10,15,50,100],//每页显示记录数
    		rowNum:10,//默认显示15条
            colModel:[
				{name : "aacid",label:"地区编码"},		
				{name : "cityName",label:"地区名称"},
				{name : "allName",label:"地区全称"},				
				{name : "spy",label:"简拼"},				
				{name : "fpy",label:"全拼    "},					
				{name : "uPerson",label:"最后修改人"},					
				{name : "population",label:"人口数量"}				
           	],
           	serializeGridData:function(postData){//添加查询条件值
				var obj = getQueryCondition();
    			$ .extend(true,obj,postData);//合并查询条件值与grid的默认传递参数
    			return obj;
    		}
      });
        
    });

    /**
    * 获取查询条件值
    */
    function getQueryCondition(){
        var obj = {};
		addAttrToObject(obj,"apid");
		addAttrToObject(obj,"aarid");
		return obj;
    }

	function addAttrToObject(obj,name){
		element = document.getElementById(name);
		var notInputValue="";
		if(element!=null){
			if(element.value==null||element.value == ""){
				if($(element).attr("uiType")!=null){
					if($(element).attr("uiType")=="checkbox"){
						var tempCheckBoxObj = $(element).find(".checkbox");
						if(tempCheckBoxObj!=null && tempCheckBoxObj.length>0){
							tempCheckBoxObj.each(function(){
								if(this.checked) {
									notInputValue  += this.value+",";
								}
							  });
							if(notInputValue!=null && notInputValue.indexOf(",")!=-1){
								notInputValue = notInputValue.substring(0,notInputValue.length-1);
							}
					
						}
					}else if($(element).attr("uiType")=="radio"){
						var tempRadioObj = $(element).find(".radio");
						if(tempRadioObj!=null && tempRadioObj.length>0){
							  tempRadioObj.each(function(){
								if(this.checked) {
									notInputValue  = this.value;
									return;
								}
							  });
						}		  
					}
					if(notInputValue == null || notInputValue == "" ){
						  return;
					}
				}else{
                   return;
				}
			}

		}else{
			return;
		}

		obj = obj || {}; 
		var value = element.value!=null?element.value:notInputValue;
		obj[name] = value;
	}

    //新增的弹出框
	var add_iframe_dialog;
	//修改的弹出框
   	var edit_iframe_dialog;
	//查看的弹出框
	var show_iframe_dialog;
  	
  	function add(){
  	//xin zeng iframe 弹出框
  	var  apid=$("#apid").val();
  	var  aarid=$("#aarid").val();
  	if(aarid==null || aarid=='' ){
  		showMessage('请选择一个城市');
  		return;
  	}
		var url=baseUrl+"/areaCity/toAddAreaCity.do?aarid="+aarid+"&apid="+apid;
		add_iframe_dialog = new biz.dialog({
			id:$('<div id="addwindow_iframe"></div>').html('<iframe id="iframeAdd" name="iframeAdd" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 600,
			height: 270,
			title: "县市州区增加"
		});
		add_iframe_dialog.open();
  	}
  	
  	//关闭新增页面，供子页面调用
  	function closeAdd(){
		add_iframe_dialog.close();
  	}
  	
    function edit(){
		var key = ICSS.utils.getSelectRowData("aacid");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var url=baseUrl+"/areaCity/toEditAreaCity.do?key="+key;
		edit_iframe_dialog = new biz.dialog({
		 	id:$('<div id="editwindow_iframe"></div>').html('<iframe id="iframeEdit" name="iframeEdit" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 600,
			height: 270,
			title: "县市州区编辑"
		});
  		edit_iframe_dialog.open();
    }
    
    //关闭编辑页面，供子页面调用
    function closeEdit(){
    	edit_iframe_dialog.close();
    }
    
    function show(){
    	var key = ICSS.utils.getSelectRowData("aacid");
		if(key.indexOf(",")>-1||key==""){
			showMessage("请选择一条数据！");
			return ;
		}
		var url=baseUrl+"/areaCity/toShowAreaCity.do?key="+key;
		show_iframe_dialog = new biz.dialog({
		 	id:$('<div id="showwindow_iframe"></div>').html('<iframe id="iframeShow" name="iframeShow" src="'+url+'" width="100%" frameborder="no" border="0" height="97%"></iframe>'),  
			modal: true,
			width: 600,
			height: 270,
				title: "县市州区详情"
		});
  		show_iframe_dialog.open();
    }
    
    //关闭查看页面，供子页面调用
    function closeShow(){
    	show_iframe_dialog.close();
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
    	var ids = ICSS.utils.getSelectRowData("aacid");
    	if(ids==""){
    		showMessage("请至少选择一条数据！");
    		return ;
    	}else{
    		new biz.alert({type:"confirm",message:I18N.msg_del_confirm,title:I18N.promp,callback:function(result){
    			if(result){
    				$ .ajax({
        				url: baseUrl+"/areaCity/deleteAreaCity.do?key="+ids,
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
    
    function initprovinceTree() {
		$.ajax({
			url : baseUrl+"/areaRegion/initRegionTree.do",
			data : {
				regionName : $('#regionName').val(),
				provinceName : $('#provinceName').val()
			},
			type : "POST",
			success : function(data, textStatus, jqXHR) {
				var setting_checkbox = {
					data:{ },
					id : "#provinceTree",
					nodes : $.parseJSON(data), //数据节点指定     
					view : {
						//addHoverDom : addHoverDom,
						//removeHoverDom : removeHoverDom,
						selectedMulti : false
					},
					edit : {
						//enable : true,
						//editNameSelectAll : true
					},
					data : {
						simpleData : {
							enable : true
						}
					},
					callback : {
						//beforeEditName : beforeEditName,
						//beforeRemove : beforeRemove,
						onClick : treeOnClick
					}
				};
				provinceTree = new biz.tree(setting_checkbox);//创建树 
			}
		});
    }
    function treeOnClick(event, treeId, treeNode){//
    	if(treeNode.isParent){
    	$("#apid").val(treeNode.id == "0" ? "" : treeNode.id);
    	$("#aarid").val('');	
    	doSearch();
    	}else{
    	$("#apid").val(treeNode.pId);
    	$("#aarid").val(treeNode.id);
    	doSearch();
    	}
    }