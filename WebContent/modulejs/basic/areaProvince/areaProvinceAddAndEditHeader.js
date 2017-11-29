var url;
$(function() {
	  url=$("#pageUrl").val();
	//绑定提交按钮click事件
	$("#submit").click(function() {
		if(!biz.validate("valid",$('#areaProvinceFormEdit')[0])){
			showWarn("数据验证失败",3000);
			return;
		}
		var options = {
			url : url,
			type : "post",
			success : function(data) {
				var d = $ .parseJSON(data);
				if(d.status==1){
					showMessage(d.message,"","",function(){
						try{
							window.parent.closeAdd();
						}catch (e) {
							window.parent.closeEdit();
						}
			     		window.parent.doSearch();
					});
				}else{
					showMessage(d.message);
				}
			
			}
		};
		// 将options传给ajaxForm
		$('#areaProvinceFormEdit').ajaxSubmit(options);
	});

	/*编辑表单数据验证*/
	new biz.validate({
		id:"#areaProvinceFormEdit",
		rules:{
		}
	}); 
});