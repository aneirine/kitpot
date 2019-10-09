<#import "parts/common.ftl" as cmn>
<#include "parts/navbar.ftl">

<@cmn.page>


    <div class="form-row">
        <div class="form-group col-md-6">
            <form action="main" class="form-inline">
                <input type="text" name="filter" placeholder="Find" class="form-control"/>
                <button type="submit" class="btn btn-primary ml-2">Find</button>
            </form>
        </div>
    </div>

    <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false"
       aria-controls="collapseExample">
        Add new message
    </a>

    <div class="collapse <#if message??>show</#if>" id="collapseExample">
        <div class="form-group">

            <form method="post" enctype="multipart/form-data" class="mt-2">
                <div class="form-group">
                    <input type="text" name="text" placeholder="text"
                           value="<#if message??>${message.text}</#if>"
                           class="form-control ${(textError??)?string('is-invalid', '')}"/>
                    <#if textError??>
                        <div class="invalid-feedback">
                            ${textError}
                        </div>
                    </#if>
                </div>
                <div class="form-group">
                    <input type="text" name="tag" placeholder="tag" class="form-control"/>
                </div>
                <div class="form-group">
                    <div class="custom-file">
                        <input type="file" name="file" id="customFile">
                        <label class="custom-file-label" for="customFile">Choose File</label>

                    </div>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-primary">Add</button>
            </form>
        </div>

    </div>


    <div class="form-row mt-3">
        <div class="form-group col-md-1">
            <form action="/deleteAll" method="post" class="form-inline">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-primary">Delete All</button>
            </form>
        </div>

        <div class="form-group ml-3">
            <form action="/showAllMyMessages" method="post" class="form-inline">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-primary">Show All Mine</button>
            </form>
        </div>

        <div class="form-group ml-3">
            <form action="/showAll" method="post" class="form-inline">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-primary">Show All</button>
            </form>
        </div>

    </div>


    <div class="form-row mt-3">
        <div class="form-group col-md-6">

            <form action="deleteById" method="post" class="form-inline">
                <input type="number" name="id" placeholder="Write a number" class="form-control">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button type="submit" class="btn btn-primary ml-2">Delete</button>
            </form>
        </div>
    </div>




    <div class="card-columns">
        <#list messages as message>
            <div class="card my-3" style="width: 18rem;">
                <#if message.filename??>
                    <img class="card-img-top" src="/img/${message.filename}">
                </#if>
                <div class="m-2">
                    <span>${message.text}</span>
                    <i>${message.tag}</i>
                    <p>${message.id}</p>
                </div>
                <div class="card-footer text-muted">
                    ${message.authorName}
                </div>

            </div>
        <#else >
            No messages

        </#list>
    </div>

</@cmn.page>