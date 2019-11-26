<#include "security.ftl">

<#import "login.ftl" as lgn>
<#--navbar-light   bg-light-->
<div class="navigation">

    <div class="container">


        <nav class="navbar navbar-expand-lg">

           <nav class="navbar">
                <a class="navbar-brand links" href="/">
                    Main page
                   <#-- <img src="../public/img/logo_pink_small.png" width="30" height="40" alt="">-->
                </a>
            </nav>

            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                    aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">

                    <div class="form-row">
                        <div class="form-group  ">

                            <div class="input-group">

                                <form action="main" class="form-inline" id="search_form">
                                    <input type="text" name="filter" placeholder="Find"
                                           class="form-control"/>
                                    <#-- <button type="submit" class="btn btn-primary ml-2">Find</button>-->
                                </form>
                            </div>

                        </div>
                    </div>

                </ul>

                <#if isAdmin>
                    <a class="nav-link links" href="/user">UserList</a>
                </#if>


                <nav class="navbar">
                    <a class="navbar-brand links" href="/user/profile/${currentUserId}">
                        ${name}
                        <#--  <img src="../public/img/oval.png" class="offset-md-2 mr-3">-->
                        <#if user_photo??>
                            <img src="/img/${user_photo}" class="offset-md-2 mr-3" style="border-radius: 50%; width: 50px; height: 50px;">
                        </#if>

                    </a>
                </nav>


                <div class="mr-3">
                    <@lgn.logout />
                </div>
            </div>


        </nav>

    </div>
</div>