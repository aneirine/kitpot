<#import "parts/common.ftl" as cmn>
<#include "parts/navbar.ftl">
<@cmn.page>
<h3>${userChannel.username}</h3>
<div class="type">${type}</div>

    <ul class="list-group">

        <#list users as user>
            <li class="list-group-item">
                <a href="/user/profile/${user.id}">${user.getUsername()}</a>
            </li>
        </#list>
    </ul>



</@cmn.page>