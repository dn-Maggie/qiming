<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en" class="no-js">
<head lang="en">
<%@ include file="header.jsp"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/styles/icon-font/iconfont.css">
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/styles/icon-font/info-iconfont.css">
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/styles/statistic/style.css">

<!--ace框架-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/static/css/ace.min.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/static/css/ace-rtl.min.css" />
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath() %>/static/css/ace-skins.min.css" />
<script
	src="<%=request.getContextPath() %>/static/js/jquery.easy-pie-chart.min.js"></script>

<script src="<%=request.getContextPath() %>/js/statistic/modernizr.js"></script>
<!-- Modernizr -->
<title></title>
<script type="text/javascript">
	jQuery(function($) {
		$('.easy-pie-chart.percentage').each(function(){
			var barColor = $(this).data('color') || '#26a711';
			var trackColor = barColor == 'rgba(255,255,255,0.95)' ? 'rgba(255,255,255,0.25)' : '#FFF';
			var size = parseInt($(this).data('size')) || 50;
			$(this).easyPieChart({
				barColor: barColor,
				trackColor: trackColor,
				scaleColor: false,
				lineCap: 'butt',
				lineWidth:4,
				animate: /msie\s*(8|7|6)/.test(navigator.userAgent.toLowerCase()) ? false : 1000,
				size: size
			});
		})
	});
	
		function lookMore(id,did,term){
		  	var url = baseUrl + '/'+did+'/toList'+id+'.do?term='+term;
		  	window.parent.document.getElementById('iframepage').src=url;	 
		}
	</script>
</head>
<body onselect="return false;" style="background: #fff">
	<div class="cd-pricing-container cd-full-width cd-secondary-theme">
		<ul class="cd-pricing-list cd-bounce-invert">
			<li style="width: 20%">
				<ul class="cd-pricing-wrapper">
					<li data-type="monthly" class="is-visible willStu"
						id="MarketStudent" did="marketStudent" term="month"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe883;</i> <label>今日新增录入
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big" title="今日新增录入">${model.currMonthMarkStu.markStuCount}</span>
							</div>
							<c:if
								test="${model.currMonthMarkStu.markStuCount-model.beforeMonthMarkStu.markStuCount>=0&&model.beforeMonthMarkStu.markStuCount>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currMonthMarkStu.markStuCount-model.beforeMonthMarkStu.markStuCount)/model.beforeMonthMarkStu.markStuCount}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currMonthMarkStu.markStuCount-model.beforeMonthMarkStu.markStuCount<0&&model.beforeMonthMarkStu.markStuCount>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeMonthMarkStu.markStuCount-model.currMonthMarkStu.markStuCount)/model.beforeMonthMarkStu.markStuCount}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div>
					</li>

					<li data-type="yearly" class="is-hidden willStu" id="MarketStudent"
						did="marketStudent" term="year"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe883;</i> <label>新增意向学员
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big" title="本年新增意向学员">${model.currYearMarkStu.markStuCount}</span>
							</div>
							<c:if
								test="${model.currYearMarkStu.markStuCount - model.beforeYearMarkStu.markStuCount>=0&&model.beforeYearMarkStu.markStuCount>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currYearMarkStu.markStuCount-model.beforeYearMarkStu.markStuCount)/model.beforeYearMarkStu.markStuCount}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currYearMarkStu.markStuCount - model.beforeYearMarkStu.markStuCount<0&&model.beforeYearMarkStu.markStuCount>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeYearMarkStu.markStuCount-model.currYearMarkStu.markStuCount)/model.beforeYearMarkStu.markStuCount}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div>
					</li>
				</ul> <!-- .cd-pricing-wrapper -->
			</li>

			<li style="width: 20%">
				<ul class="cd-pricing-wrapper">
					<li data-type="monthly" class="is-visible oop" id="VipStudent"
						did="vipStudent" term="month"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe883;</i> <label>新增VIP学员
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big" title="本月新增报名学员">${model.currMonth.vipcnt}</span>
							</div>
							<c:if
								test="${model.currMonth.vipcnt-model.beforeMonth.vipcnt>=0&&model.beforeMonth.vipcnt>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currMonth.vipcnt - model.beforeMonth.vipcnt)/model.beforeMonth.vipcnt}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currMonth.vipcnt-model.beforeMonth.vipcnt<0&&model.beforeMonth.vipcnt>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeMonth.vipcnt - model.currMonth.vipcnt)/model.beforeMonth.vipcnt}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div>
					</li>

					<li data-type="yearly" class="is-hidden oop" id="VipStudent"
						did="vipStudent" term="year"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe883;</i> <label>新增VIP学员
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big" title="本年新增报名学员">${model.currYear.vipcnt}</span>
							</div>
							<c:if
								test="${model.currYear.vipcnt - model.beforeYear.vipcnt>=0&&model.beforeYear.vipcnt>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currYear.vipcnt - model.beforeYear.vipcnt)/model.beforeYear.vipcnt}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currYear.vipcnt - model.beforeYear.vipcnt<0&&model.beforeYear.vipcnt>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeYear.vipcnt - model.currYear.vipcnt)/model.beforeYear.vipcnt}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div>
					</li>
				</ul> <!-- .cd-pricing-wrapper -->
			</li>

			<li class="cd-popular" style="width: 20%">
				<ul class="cd-pricing-wrapper">
					<li data-type="monthly" class="is-visible vipStu" id="VipStudent"
						did="vipStudent" term="month"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe81d;</i> <label>新增订单
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big" title="本月新增报名订单">${model.currMonth.cnt}</span>
							</div>
							<c:if
								test="${model.currMonth.cnt - model.beforeMonth.cnt>=0&&model.beforeMonth.cnt>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currMonth.cnt - model.beforeMonth.cnt)/model.beforeMonth.cnt}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currMonth.cnt - model.beforeMonth.cnt<0&&model.beforeMonth.cnt>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeMonth.cnt - model.currMonth.cnt)/model.beforeMonth.cnt}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div> <!-- .cd-pricing-header -->
					</li>

					<li data-type="yearly" class="is-hidden vipStu" id="VipStudent"
						did="vipStudent" term="year"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe81d;</i> <label>新增订单
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big" title="本年新增报名订单">${model.currYear.cnt}</span>
							</div>
							<c:if
								test="${model.currYear.cnt - model.beforeYear.cnt>=0&&model.beforeYear.cnt>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currYear.cnt - model.beforeYear.cnt)/model.beforeYear.cnt}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currYear.cnt - model.beforeYear.cnt<0&&model.beforeYear.cnt>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeYear.cnt - model.currYear.cnt)/model.beforeYear.cnt}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div> <!-- .cd-pricing-header -->
					</li>
				</ul>
			</li>
			<!-- .cd-pricing-wrapper -->

			<li style="width: 40%">
				<ul class="cd-pricing-wrapper">
					<li data-type="monthly" class="is-visible oor" id="AccountFlow"
						did="accountFlow" term="monthcost"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe81d;</i> <label>消费支出
									<i class="info-iconfont" title="本月已除去学费退款的成本费用">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currMonthMoney.loan-model.currMonthxf.xftk-model.currMonthxf.xftj}"
										pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
							<c:if
								test="${(model.currMonthMoney.loan-model.currMonthxf.xftk-model.currMonthxf.xftj) - (model.beforeMonthMoney.loan-model.beforeMonthxf.xftk-model.beforeMonthxf.xftj)>=0&&(model.beforeMonthMoney.loan-model.beforeMonthxf.xftk-model.beforeMonthxf.xftj)>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${((model.currMonthMoney.loan-model.currMonthxf.xftk-model.currMonthxf.xftj) - (model.beforeMonthMoney.loan-model.beforeMonthxf.xftk-model.beforeMonthxf.xftj))/(model.beforeMonthMoney.loan-model.beforeMonthxf.xftk-model.beforeMonthxf.xftj)}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${(model.currMonthMoney.loan-model.currMonthxf.xftk-model.currMonthxf.xftj) - (model.beforeMonthMoney.loan-model.beforeMonthxf.xftk-model.beforeMonthxf.xftj)<0&&(model.beforeMonthMoney.loan-model.beforeMonthxf.xftk-model.beforeMonthxf.xftj)>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${((model.beforeMonthMoney.loan-model.beforeMonthxf.xftk-model.beforeMonthxf.xftj) - (model.currMonthMoney.loan-model.currMonthxf.xftk-model.currMonthxf.xftj))/(model.beforeMonthMoney.loan-model.beforeMonthxf.xftk-model.beforeMonthxf.xftj)}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div>
					</li>

					<li data-type="yearly" class="is-hidden oor" id="AccountFlow"
						did="accountFlow" term="yearcost"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe81d;</i> <label>消费支出
									<i class="info-iconfont" title="本年已除去学费退款的成本费用">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currYearMoney.loan-model.currYearxf.xftk-model.currYearxf.xftj}"
										pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
							<c:if
								test="${(model.currYearMoney.loan-model.currYearxf.xftk-model.currYearxf.xftj) - (model.beforeYearMoney.loan-model.beforeYearxf.xftk-model.beforeYearxf.xftj)>=0&&(model.beforeYearMoney.loan-model.beforeYearxf.xftk-model.beforeYearxf.xftj)>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${((model.currYearMoney.loan-model.currYearxf.xftk-model.currYearxf.xftj) - (model.beforeYearMoney.loan-model.beforeYearxf.xftk-model.beforeYearxf.xftj))/(model.beforeYearMoney.loan-model.beforeYearxf.xftk-model.beforeYearxf.xftj)}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${(model.currYearMoney.loan-model.currYearxf.xftk-model.currYearxf.xftj) - (model.beforeYearMoney.loan-model.beforeYearxf.xftk-model.beforeYearxf.xftj)<0&&(model.beforeYearMoney.loan-model.beforeYearxf.xftk-model.beforeYearxf.xftj)>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${((model.beforeYearMoney.loan-model.beforeYearxf.xftk-model.beforeYearxf.xftj) - (model.currYearMoney.loan-model.currYearxf.xftk-model.currYearxf.xftj))/(model.beforeYearMoney.loan-model.beforeYearxf.xftk-model.beforeYearxf.xftj)}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div> <!-- .cd-pricing-header -->
					</li>

				</ul> <!-- .cd-pricing-wrapper -->
			</li>

			<li class="cd-popular" style="width: 40%">
				<ul class="cd-pricing-wrapper">
					<li data-type="monthly" class="is-visible newOrder" id="VipStudent"
						did="vipStudent" term="monthshouldPay"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xf0191;</i> <label>应收总额
									<i class="info-iconfont" title="本月已除去退款学员的应收账款">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currMonth.shouldPay}" pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
							<c:if
								test="${model.currMonth.shouldPay-model.beforeMonth.shouldPay>=0&&model.beforeMonth.shouldPay>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currMonth.shouldPay - model.beforeMonth.shouldPay)/model.beforeMonth.shouldPay}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currMonth.shouldPay-model.beforeMonth.shouldPay<0&&model.beforeMonth.shouldPay>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeMonth.shouldPay - model.currMonth.shouldPay)/model.beforeMonth.shouldPay}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div> <!-- .cd-pricing-header -->
					</li>

					<li data-type="yearly" class="is-hidden newOrder" id="VipStudent"
						did="vipStudent" term="yearshouldPay"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xf0191;</i> <label>应收总额
									<i class="info-iconfont" title="本年已除去退款学员的应收账款">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currYear.shouldPay}" pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
							<c:if
								test="${model.currYear.shouldPay - model.beforeYear.shouldPay>=0&&model.beforeYear.shouldPay>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currYear.shouldPay - model.beforeYear.shouldPay)/model.beforeYear.shouldPay}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currYear.shouldPay - model.beforeYear.shouldPay<0&&model.beforeYear.shouldPay>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeYear.shouldPay - model.currYear.shouldPay)/model.beforeYear.shouldPay}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div> <!-- .cd-pricing-header -->
					</li>
				</ul> <!-- .cd-pricing-wrapper -->
			</li>

			<li style="width: 30%">
				<ul class="cd-pricing-wrapper">
					<li data-type="monthly" class="is-visible oop" id="AccountFlow"
						did="accountFlow" term="monthxftk"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe7de;</i> <label>退款总额
									<i class="info-iconfont" title="本月退款学员退款总额">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currMonthxf.xftk}" pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
							<c:if
								test="${model.currMonthxf.xftk - model.beforeMonthxf.xftk>=0&&model.beforeMonthxf.xftk>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currMonthxf.xftk - model.beforeMonthxf.xftk)/model.beforeMonthxf.xftk}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currMonthxf.xftk - model.beforeMonthxf.xftk<0&&model.beforeMonthxf.xftk>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeMonthxf.xftk - model.currMonthxf.xftk)/model.beforeMonthxf.xftk}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div> <!-- .cd-pricing-header -->
					</li>

					<li data-type="yearly" class="is-hidden oop" id="AccountFlow"
						did="accountFlow" term="yearxftk"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe7de;</i> <label>退款总额
									<i class="info-iconfont" title="本年退款学员退款总额">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currYearxf.xftk}" pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
							<c:if
								test="${model.currYearxf.xftk - model.beforeYearxf.xftk>=0&&model.beforeYearxf.xftk>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currYearxf.xftk - model.beforeYearxf.xftk)/model.beforeYearxf.xftk}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currYearxf.xftk - model.beforeYearxf.xftk<0&&model.beforeYearxf.xftk>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeYearxf.xftk - model.currYearxf.xftk)/model.beforeYearxf.xftk}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div> <!-- .cd-pricing-header -->
					</li>
				</ul> <!-- .cd-pricing-wrapper -->
			</li>

			<li class="cd-popular" style="width: 30%">
				<ul class="cd-pricing-wrapper">
					<li data-type="monthly" class="is-visible vipStu" did="vipStudent"
						id="VipStudent" term="monthowePay"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe765;</i> <label>应收欠款
									<i class="info-iconfont" title="本月学员剩余贷款总额">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currMonth.owePay}" pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
							<c:if
								test="${model.currMonth.owePay-model.beforeMonth.owePay>=0&&model.beforeMonth.owePay>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currMonth.owePay - model.beforeMonth.owePay)/model.beforeMonth.owePay}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currMonth.owePay-model.beforeMonth.owePay<0&&model.beforeMonth.owePay>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeMonth.owePay - model.currMonth.owePay)/model.beforeMonth.owePay}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div> <!-- .cd-pricing-header -->
					</li>

					<li data-type="yearly" class="is-hidden vipStu" did="vipStudent"
						id="VipStudent" term="yearowePay"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe765;</i> <label>应收欠款
									<i class="info-iconfont" title="本年学员剩余贷款总额">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currYear.owePay}" pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
							<c:if
								test="${model.currYear.owePay - model.beforeYear.owePay>=0&&model.beforeYear.owePay>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currYear.owePay - model.beforeYear.owePay)/model.beforeYear.owePay}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currYear.owePay - model.beforeYear.owePay<0&&model.beforeYear.owePay>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeYear.owePay - model.currYear.owePay)/model.beforeYear.owePay}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div> <!-- .cd-pricing-header -->
					</li>
				</ul> <!-- .cd-pricing-wrapper -->
			</li>

			<li style="width: 33%">
				<ul class="cd-pricing-wrapper">
					<li data-type="monthly" class="is-visible vipStu" did="accountFlow"
						id="AccountFlow" term="monthmajorIncome"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe6a9;</i> <label>总业绩
									<i class="info-iconfont" title="本月实收报名费+本月实收补款">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<div class="easy-pie-chart percentage"
									style="margin-right: 10px"
									data-percent="${(model.currMonthxf.xfsr+model.currMonthxf.xfbk)/(model.perfTarget/100)}"
									data-size="56">
									<span class="percent"> <fmt:formatNumber
											value="${(model.currMonthxf.xfsr+model.currMonthxf.xfbk)/(model.perfTarget/100)}"
											pattern="0.0" type="number"></fmt:formatNumber>
									</span>%
								</div>
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currMonthxf.xfsr+model.currMonthxf.xfbk}"
										pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
						</div> <!-- .cd-pricing-header -->
					</li>

					<li data-type="yearly" class="is-hidden vipStu" did="accountFlow"
						id="AccountFlow" term="majorIncome"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe6a9;</i> <label>总业绩
									<i class="info-iconfont" title="本年实收报名费+本年实收补款">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currYear.xfsr + model.currYear.xfbk}"
										pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
							<c:if
								test="${model.currYear.xfsr + model.currYear.xfbk - model.beforeYear.xfsr - model.beforeYear.xfbk>=0&&model.beforeYear.xfsr + model.beforeYear.xfbk>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currYear.xfsr + model.currYear.xfbk - model.beforeYear.xfsr - model.beforeYear.xfbk)/(model.beforeYear.xfsr + model.beforeYear.xfbk)}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currYear.xfsr + model.currYear.xfbk - model.beforeYear.xfsr - model.beforeYear.xfbk<0&&model.beforeYear.xfsr + model.beforeYear.xfbk>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeYear.xfsr + model.beforeYear.xfbk - model.currYear.xfsr - model.currYear.xfbk)/(model.beforeYear.xfsr + model.beforeYear.xfbk)}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div>
					</li>
				</ul>
			</li>

			<li style="width: 33%">
				<ul class="cd-pricing-wrapper">
					<li data-type="monthly" class="is-visible allCost" id="AccountFlow"
						did="accountFlow" term="monthactualPay"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe6a9;</i> <label>实收报名费
									<i class="info-iconfont" title="本月新增学员首次支付总额+本月其他方式学费收入">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currMonthxf.xfsr}" pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
							<c:if
								test="${model.currMonthxf.xfsr - model.beforeMonthxf.xfsr>=0&&model.beforeMonthxf.xfsr>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currMonthxf.xfsr - model.beforeMonthxf.xfsr)/model.beforeMonthxf.xfsr}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currMonthxf.xfsr - model.beforeMonthxf.xfsr<0&&model.beforeMonthxf.xfsr>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeMonthxf.xfsr - model.currMonthxf.xfsr)/model.beforeMonthxf.xfsr}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div> <!-- .cd-pricing-header -->
					</li>

					<li data-type="yearly" class="is-hidden allCost" id="AccountFlow"
						did="accountFlow" term="yearactualPay"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe6a9;</i> <label>实收报名费
									<i class="info-iconfont" title="本年新增学员首次支付总额+本年其他方式学费收入">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currYearxf.xfsr}" pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
							<c:if
								test="${model.currYearxf.xfsr - model.beforeYearxf.xfsr>=0&&model.beforeYearxf.xfsr>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currYearxf.xfsr - model.beforeYearxf.xfsr)/model.beforeYearxf.xfsr}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currYearxf.xfsr - model.beforeYearxf.xfsr<0&&model.beforeYearxf.xfsr>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeYearxf.xfsr - model.currYearxf.xfsr)/model.beforeYearxf.xfsr}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div> <!-- .cd-pricing-header -->
					</li>
				</ul> <!-- .cd-pricing-wrapper -->
			</li>

			<li class="cd-popular" style="width: 34%">
				<ul class="cd-pricing-wrapper">
					<li data-type="monthly" class="is-visible complain"
						did="continuePay" id="ContinuePay" term="month"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe6cc;</i> <label>实收补款
									<i class="info-iconfont" title="本月收到补款总额">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currMonthxf.xfbk}" pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
							<c:if
								test="${model.currMonthxf.xfbk - model.beforeMonthxf.xfbk>=0&&model.beforeMonthxf.xfbk>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currMonthxf.xfbk - model.beforeMonthxf.xfbk)/model.beforeMonthxf.xfbk}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currMonthxf.xfbk - model.beforeMonthxf.xfbk<0&&model.beforeMonthxf.xfbk>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeMonthxf.xfbk - model.currMonthxf.xfbk)/model.beforeMonthxf.xfbk}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div>
					</li>

					<li data-type="yearly" class="is-hidden complain" did="continuePay"
						id="ContinuePay" term="year"
						onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
						<div class="cd-pricing-header topper">
							<span class="nameTop"> <i class="iconfont">&#xe81d;</i> <label>实收补款
									<i class="info-iconfont" title="本年收到补款总额">&#xe637;</i>
							</label>
							</span>
							<div class="cd-price">
								<span class="cd-value-big"> <fmt:formatNumber
										value="${model.currYearxf.xfbk}" pattern="0" type="number"></fmt:formatNumber>
								</span>
							</div>
							<c:if
								test="${model.currYearxf.xfbk-model.beforeYearxf.xfbk>=0&&model.beforeYearxf.xfbk>0}">
								<div class="stat stat-success">
									<fmt:formatNumber
										value="${(model.currYearxf.xfbk - model.beforeYearxf.xfbk)/model.beforeYearxf.xfbk}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
							<c:if
								test="${model.currYearxf.xfbk-model.beforeYearxf.xfbk<0&&model.beforeYearxf.xfbk>0}">
								<div class="stat stat-important">
									<fmt:formatNumber
										value="${(model.beforeYearxf.xfbk - model.currYearxf.xfbk)/model.beforeYearxf.xfbk}"
										type="percent"></fmt:formatNumber>
								</div>
							</c:if>
						</div>
					</li>
				</ul>
			</li>

		</ul>
		<!-- .cd-pricing-list -->
		<div class="cd-pricing-switcher">
			<p class="fieldset">
				<input type="radio" name="duration" value="monthly" id="monthly"
					checked> <label for="monthly">月</label> <input type="radio"
					name="duration" value="yearly" id="yearly"> <label
					for="yearly">年</label> <span class="cd-switch"></span>
			</p>
		</div>
		<!-- .cd-pricing-switcher -->
	</div>
	<!-- .cd-pricing-container -->

	<!-- 报表部分 -->
	<div class="cd-center-container">
		<div class="center-title">
			<span class="nameCenter"> <i class="iconfont-xsmall">&#xe7c6;
			</i>总报表
			</span>
		</div>
		<ul class="cd-popular cd-center">
			<li data-type="monthly" class="is-visible" did="vipStudent"
				id="VipStudent" term="vipCnt"
				onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
				<div class="cd-pricing-header center">
					<span class="nameCenter"> <i class="iconfont-small">&#xe62f;</i>
						<label>总会员</label>
					</span>
					<div class="cd-price">
						<span class="cd-value-small" title="报名学员总数"> <fmt:formatNumber
								value="${model.all.vipcnt}" pattern="0" type="number"></fmt:formatNumber>
						</span>
					</div>
				</div> <!-- .cd-pricing-header center -->
			</li>
			<li data-type="monthly" class="is-visible" did="vipStudent"
				id="VipStudent" term="orderCnt"
				onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
				<div class="cd-pricing-header center">
					<span class="nameCenter"> <i class="iconfont-small">&#xe7c6;</i>
						<label>订单量</label>
					</span>
					<div class="cd-price">
						<span class="cd-value-small" title="总报名次数">${model.all.cnt}</span>
					</div>
				</div> <!-- .cd-pricing-header center -->
			</li>

			<li data-type="monthly" class="is-visible" did="accountFlow"
				id="AccountFlow" term="majorIncome"
				onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
				<div class="cd-pricing-header center">
					<span class="nameCenter"> <i class="iconfont-small">&#xe623;</i>
						<label>主营业务收入 <i class="info-iconfont"
							title="本年实收报名费+本年实收补款-本年退款总额">&#xe637;</i>
					</label>
					</span>
					<div class="cd-price">
						<!--  <span class="cd-value-small">${model.allxf.xfsr+model.allxf.xfbk-model.allxf.xftk}</span>-->
						<span class="cd-value-small"> <fmt:formatNumber
								value="${model.all.actualPay}" pattern="0" type="number"></fmt:formatNumber>
						</span>
					</div>
				</div> <!-- .cd-pricing-header center -->
			</li>
			<li data-type="monthly" class="is-visible" did="accountFlow"
				id="AccountFlow" term="QTSR"
				onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
				<div class="cd-pricing-header center">
					<span class="nameCenter"> <i class="iconfont-small">&#xe623;</i>
						<label>其他业务收入 <i class="info-iconfont" title="本年其他收入总额">&#xe637;</i>
					</label>
					</span>
					<div class="cd-price">
						<span class="cd-value-small"> <fmt:formatNumber
								value="${model.allxf.qtsr}" pattern="0" type="number"></fmt:formatNumber>
						</span>
					</div>
				</div>
			</li>

			<li data-type="monthly" class="is-visible" did="accountFlow"
				id="AccountFlow" term="majorCost"
				onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
				<div class="cd-pricing-header center">
					<span class="nameCenter"> <i class="iconfont-small">&#xe7de;</i>
						<label>主营业务成本 <i class="info-iconfont"
							title="总成本-学费退款-其他业务支出">&#xe637;</i>
					</label>
					</span>
					<div class="cd-price">
						<span class="cd-value-small"> <fmt:formatNumber
								value="${model.allMoney.loan-model.allxf.xftk-model.allxf.qtzc}"
								pattern="0" type="number"></fmt:formatNumber>
						</span>
					</div>
				</div> <!-- .cd-pricing-header center -->
			</li>
			<li data-type="monthly" class="is-visible" did="accountFlow"
				id="AccountFlow" term="QT"
				onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
				<div class="cd-pricing-header center">
					<span class="nameCenter"> <i class="iconfont-small">&#xe7de;</i>
						<label>其他业务支出</label>
					</span>
					<div class="cd-price">
						<span class="cd-value-small"> <fmt:formatNumber
								value="${model.allxf.qtzc}" pattern="0" type="number"></fmt:formatNumber>
						</span>
					</div>
				</div> <!-- .cd-pricing-header center -->
			</li>

			<li data-type="monthly" class="is-visible" did="accountFlow"
				id="AccountFlow" term="allCost"
				onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
				<div class="cd-pricing-header center">
					<span class="nameCenter"> <i class="iconfont-small">&#xe7de;</i>
						<label>总收入 <i class="info-iconfont" title="主营业务收入+其他业务收入">&#xe637;</i>
					</label>
					</span>
					<div class="cd-price">
						<span class="cd-value-small"> <fmt:formatNumber
								value="${model.all.actualPay+model.allxf.qtsr}" pattern="0"
								type="number"></fmt:formatNumber>
						</span>
					</div>
				</div> <!-- .cd-pricing-header center -->
			</li>
			<li data-type="monthly" class="is-visible" did="accountFlow"
				id="AccountFlow" term="allCost"
				onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
				<div class="cd-pricing-header center">
					<span class="nameCenter"> <i class="iconfont-small">&#xe7de;</i>
						<label>总成本 <i class="info-iconfont" title="主营业务成本+其他业务支出">&#xe637;</i>
					</label>
					</span>
					<div class="cd-price">
						<span class="cd-value-small"> <fmt:formatNumber
								value="${model.allMoney.loan-model.allxf.xftk-model.allxf.xftj}"
								pattern="0" type="number"></fmt:formatNumber>
						</span>
					</div>
				</div> <!-- .cd-pricing-header center -->
			</li>
			<li data-type="monthly" class="is-visible" did="accountFlow"
				id="AccountFlow" term="allProfit"
				onclick="lookMore(this.id,this.attributes['did'].value,this.attributes['term'].value)">
				<div class="cd-pricing-header center">
					<span class="nameCenter"> <i class="iconfont-small">&#xf01c9;</i>
						<label>总利润 <i class="info-iconfont" title="总收入-总成本">&#xe637;</i>
					</label>
					</span>
					<div class="cd-price">
						<span class="cd-value-small" id="profit"> <fmt:formatNumber
								value="${model.all.actualPay+model.allxf.qtsr-model.allMoney.loan+model.allxf.xftk+model.allxf.xftj}"
								pattern="0" type="number"></fmt:formatNumber>
						</span>
					</div>
				</div>
			</li>
		</ul>
	</div>
	<script src="<%=request.getContextPath() %>/js/statistic/main.js"></script>
	<!-- Resource jQuery -->
</body>
</html>

