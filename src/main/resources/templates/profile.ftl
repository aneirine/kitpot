<#import "parts/common.ftl" as cmn>
<#include "parts/navbar.ftl">
<@cmn.page>
<h3>${username}</h3>

    <a href="/user/profileEdit">Edit profile</a>

    <h3>Subscribers: ${currentSubscribers}</h3>
    <h3>Subscriptions: ${currentSubscriptions}</h3>


</@cmn.page>