<#include "/page/front/common/_layout.ftl"/>
<@html title="首页 - ${siteTitle!}" description="" page_tab="${tab!}" sidebar_user_info="show">
<div class="panel panel-default">
    <div class="panel-body">
        <p style="font-size: 18px; font-weight: 300;margin: 10px 0px 0px 20px;">
            <#if msg??>
                您今天已经领取了奖励，明天在来吧
            <#else>
                每日登录奖励：恭喜你获取
                <b style="font-size: 24px; font-weight: 500; color: red;">${score!}</b>
                积分&nbsp;&nbsp; 连续签到<b style="font-size: 24px; font-weight: 500; color: red;"><a href="${baseUrl!}/mission/top10"> ${day!} </a></b>天
            </#if>
            <br>
            <a href="${baseUrl!}/" class="btn btn-raised btn-default">返回首页</a>
        </p>
        <br>
    </div>
</div>
</@html>