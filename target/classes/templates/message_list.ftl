<#import "parts/pager.ftl" as pager>


    <div class="col-md-8">
        <@pager.pager url page />
        <#list page.content as message>

            <div class="card mb-3">
                <div class="row no-gutters">
                    <div class="col-md-4">
                        <#if message.filename??>
                            <img class="card-img" src="/img/${message.filename}">
                        </#if>
                    </div>

                    <div class="card-body">
                        <span class="card-title">${message.text}</span>
                        <i class="card-text">${message.tag}</i>
                        <p class="card-text">${message.id}</p>

                        <p class="card-text">
                            <small class="text-muted">

                                <a href="/user/profile/name/${message.authorName}">
                                    ${message.authorName}</a>
                            </small>
                        </p>


                        <a href="/deleteById/${message.id}">Delete</a>


                        <#-- <#include "parts/message_edit.ftl" />-->
                    </div>
                </div>
            </div>
        <#else >
            No messages

        </#list>

        <@pager.pager url page />
    </div>
