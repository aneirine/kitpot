<#import "parts/common.ftl" as cmn>
<#include "parts/navbar.ftl">
<@cmn.page>
    <h3>${username}</h3>

    <#if isCurrentUser>
        <a href="/user/profileEdit">Edit profile</a>
    </#if>

    <#if !isCurrentUser>
        <#if isSubscriber>
            <a class="btn btn-info" href="/user/unsubscribe/${id}">Unsubscribe</a>
        <#else>
            <a class="btn btn-info" href="/user/subscribe/${id}">Subscribe</a>
        </#if>
    </#if>

    <h3>Subscribers: ${currentSubscribers}</h3>
    <h3>Subscriptions: ${currentSubscriptions}</h3>


</@cmn.page>