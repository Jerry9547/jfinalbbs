<#include "/page/front/common/_layout.ftl"/>
<@html title="设置 - ${siteTitle!}" description="" page_tab="${tab!}" sidebar_user_info="show" sidebar_create="show">
<div class="panel panel-default">
    <div class="panel-heading">
        <ol class="breadcrumb">
            <li><a href="${baseUrl!}/">首页</a></li>
            <li class="active">设置</li>
        </ol>
    </div>
    <div class="panel-body">
        <div class="alert alert-success hidden" id="setSuccess" role="alert">保存成功。</div>
        <div class="alert alert-danger hidden" id="setFailure" role="alert">保存失败。<i id="setErrMsg"></i></div>
        <form class="form form-horizontal" id="form" method="post" style="margin-top: 20px;">
            <div class="form-group">
                <label class="control-label col-sm-2">昵称</label>

                <div class="col-sm-5">
                    <input type="text" class="form-control" name="nickname" id="nickname" value="${session.user.nickname!}">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2">电子邮件</label>

                <div class="col-sm-5">
                    <input type="email" class="form-control" disabled value="${session.user.email!}">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2">个人网站</label>

                <div class="col-sm-5">
                    <input type="text" class="form-control" name="url" id="url" value="${session.user.url!}">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2">个性签名</label>

                <div class="col-sm-5">
                    <textarea name="signature" id="signature" class="form-control">${session.user.signature!}</textarea>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-2">&nbsp;</label>

                <div class="col-sm-4">
                    <button type="button" id="saveBtn" onclick="saveSetting()" class="btn btn-raised btn-info ">保存设置</button>
                </div>
            </div>
        </form>
    </div>
</div>
<div class="panel panel-default">
    <div class="panel-heading">修改头像</div>
    <div class="panel-body">
        <form action="${baseUrl!}/user/uploadAvatar" id="uploadAvatar" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="avatar">选择图片</label>
                <input type="file" name="avatar" id="avatar">
                <p class="help-block">请选择正方形图片，否则会出现变形，支持格式：.gif.jpg.png.jpeg</p>
            </div>
            <button type="submit" class="btn btn-raised btn-info ">上传</button>
        </form>
    </div>
</div>
<div class="panel panel-default">
    <div class="panel-heading">绑定第三方账号</div>
    <div class="panel-body">
        <div class="media">
            <#if session.user.qq_nickname?? && session.user.qq_nickname != "">
                <img src="${session.user.qq_avatar!}" width="25"/>
                ${session.user.qq_nickname!}
            <#else>
                <img src="${baseUrl!}/static/img/QQ24.png"/>
                腾讯QQ
            </#if>
            <div class="pull-right">
                <#if session.user.qq_open_id?? && session.user.qq_open_id != "">
                    <button class="btn btn-raised btn-danger btn-xs" id="cancelbind_qq" onclick="cancelBind('qq')">解除绑定</button>
                <#else>
                    <a class="btn btn-raised btn-info btn-xs" href="${baseUrl!}/qqlogin?source=usersetting">立即绑定</a>
                </#if>
            </div>
        </div>
        <div class="spacer"></div>
        <div class="media">
            <#if session.user.sina_nickname?? && session.user.sina_nickname != "">
                <img src="${session.user.sina_avatar!}" width="25"/>
                ${session.user.sina_nickname!}
            <#else>
                <img src="${baseUrl!}/static/img/sinaweibo24.png"/>
                新浪微博
            </#if>
            <div class="pull-right">
                <#if session.user.sina_open_id?? && session.user.sina_open_id != "">
                    <button class="btn btn-raised btn-danger btn-xs" id="cancelbind_sina" onclick="cancelBind('sina')">解除绑定</button>
                <#else>
                    <a class="btn btn-raised btn-info btn-xs" href="${baseUrl!}/weibologin?source=usersetting">立即绑定</a>
                </#if>
            </div>
        </div>
        <#--<div class="spacer"></div>-->
        <#--<div class="media">-->
            <#--<img src="${baseUrl!}/static/img/wechat24.png"/> 微信-->
            <#--<div class="pull-right">-->
                <#--<button class="btn btn-raised btn-danger btn-xs" onclick="cancelBind('wechat')">解除绑定</button>-->
            <#--</div>-->
        <#--</div>-->
    </div>
</div>
<div class="panel panel-default">
    <div class="panel-heading">令牌</div>
    <div class="panel-body">
        <div style="padding-left: 23px;">使用客户端扫描登录</div>
        <img src="http://api.k780.com:88/?app=qr.get&data=${session.user.token!}@||@${session.user.nickname!}&level=H&size=6">
    </div>
</div>

<script>
    function saveSetting() {
        var nickname = $("#nickname").val();
        var signature = $("#signature").val();
        var url = $("#url").val();
        if ($.trim(nickname) == "") {
            alert("昵称不能为空");
        } else if (signature.length > 1000) {
            alert("个性签名不得超过1000个字符");
        } else {
            $.ajax({
                url: "${baseUrl!}/user/setting",
                async: false,
                cache: false,
                type: 'post',
                dataType: "json",
                data: {
                    nickname: nickname,
                    url: url,
                    signature: signature
                },
                success: function (data) {
                    if (data.code == '200') {
                        $("#setSuccess").removeClass("hidden");
                        $("#setFailure").addClass("hidden");
                    } else {
                        $("#setErrMsg").text(data.description);
                        $("#setSuccess").addClass("hidden");
                        $("#setFailure").removeClass("hidden");
                    }
                }
            });
        }
    }

    $("#uploadAvatar").submit(function () {
        var hzs = ".gif,.jpg,.png,.jpeg";
        var avatar = $("#avatar").val();
        if(avatar) {
            var hz = avatar.substring(avatar.lastIndexOf("."), avatar.length);
            if(hzs.indexOf(hz.toLowerCase()) == -1) {
                alert("请上传正确格式的图片")
                return false;
            }
        }
    });

    function cancelBind(pt) {
        if(confirm("确定要取消绑定吗？")) {
            $("#thirdbind_" + pt).attr("disabled", true);
            $.ajax({
                url: "${baseUrl!}/user/cancelBind",
                async: false,
                cache: false,
                type: 'post',
                dataType: "json",
                data: {
                    pt: pt
                },
                success: function (data) {
                    if (data.code == '200') {
                        location.href="${baseUrl!}/user/setting";
                    } else {
                        alert(data.description);
                        $("#thirdbind_" + pt).attr("disabled", false);
                    }
                }
            });
        }
    }

</script>
</@html>