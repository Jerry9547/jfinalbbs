<#include "/page/front/common/_layout.ftl"/>
<@html title="用户注册 - ${siteTitle!}" description="用户注册" page_tab="reg" sidebar_about="show">
<div class="panel panel-default">
    <div class="panel-heading">
        <ol class="breadcrumb">
            <li><a href="${baseUrl!}/">首页</a></li>
            <li class="active">注册</li>
        </ol>
    </div>
    <div class="panel-body">
        <form class="form-horizontal" style="margin-top: 20px;">
            <#if session.open_id?? && session.open_id != ''>
                <div class="form-group">
                    <#if session.thirdlogin_type == 'qq'>
                        <label for="qq_nickname" class="col-sm-2 control-label">QQ昵称</label>
                        <div class="col-sm-8">
                            <input type="text" disabled="disabled" class="form-control" value="${session.unsave_user.qq_nickname!}"/>
                        </div>
                    <#elseif session.thirdlogin_type == 'sina'>
                        <label for="qq_nickname" class="col-sm-2 control-label">微博昵称</label>
                        <div class="col-sm-8">
                            <input type="text" disabled="disabled" value="${session.unsave_user.sina_nickname!}"/>
                        </div>
                    </#if>
                </div>
            </#if>
            <div class="form-group">
                <label for="email" class="col-sm-2 control-label">邮箱</label>
                <div class="col-sm-8">
                    <div class="input-group">
                        <input type="email" class="form-control" id="reg_email" placeholder="邮箱(必填)"/>
                        <span class="input-group-btn">
                            <button class="btn btn-raised btn-default" type="button" id="send_email_btn" onclick="sendEmail()">发送邮件</button>
                        </span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="valicode" class="col-sm-2 control-label">验证码</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="valicode" placeholder="验证码(必填)">
                </div>
            </div>
            <div class="form-group">
                <label for="nickname" class="col-sm-2 control-label">昵称</label>
                <div class="col-sm-8">
                    <input type="text" class="form-control" id="reg_nickname" placeholder="昵称(必填)">
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="col-sm-2 control-label">密码</label>
                <div class="col-sm-8">
                    <input type="password" class="form-control" id="reg_password" placeholder="密码(必填)">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-8">
                    <span id="regMsg"></span>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-8">
                    <a onclick="reg()" id="reg_btn" class="btn btn-raised btn-default">注册</a>
                </div>
            </div>
        </form>
    </div>
</div>
<script>
    function sendEmail() {
        $("#send_email_btn").attr("disabled", true);
        $.ajax({
            url: "${baseUrl!}/sendValiCode",
            async: false,
            cache: false,
            type: 'post',
            dataType: "json",
            data: {
                type: 'reg',
                email: $("#reg_email").val()
            },
            success: function (data) {
                if (data.code == '200') {
                    $("#send_email_btn").html("发送成功");
                    $("#reg_email").attr("disabled", true);
                } else {
                    $("#regMsg").css("color", "red").html(data.description);
                    $("#send_email_btn").attr("disabled", false);
                }
            }
        });
    }
    function reg() {
        $("#reg_btn").attr("disabled", true);
        $.ajax({
            url: "${baseUrl!}/reg",
            async: false,
            cache: false,
            type: 'post',
            dataType: "json",
            data: {
                valicode: $("#valicode").val(),
                reg_email: $("#reg_email").val(),
                reg_password: $("#reg_password").val(),
                reg_nickname: $("#reg_nickname").val()
            },
            success: function (data) {
                if (data.code == '200') {
                    location.href="${baseUrl!}/";
                } else {
                    $("#regMsg").css("color", "red").html(data.description);
                    $("#reg_btn").attr("disabled", false);
                }
            }
        });
    }
</script>
</@html>