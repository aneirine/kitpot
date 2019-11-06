<#import "parts/common.ftl" as cmn>
<#include "parts/navbar.ftl">

<@cmn.page>



    <div class="row">

        <div class="col-md-2">

            <ul class="list-group">

                <div class="grey"></div>
                <form action="/add" method="get" class="form-inline">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button type="submit" class="list-group-item list-group-item-action">
                        Add new post
                    </button>

                </form>
            </ul>
        </div>

            <#include "message_list.ftl" />




        <div class="col-md-2">
            <ul class="list-group">

                <div class="grey"></div>

                <form action="/showAll" method="post" class="form-inline">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button type="submit" class="list-group-item list-group-item-action">Show All</button>
                </form>

                <form action="/showAllMyMessages" method="post" class="form-inline">
                    <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                    <button type="submit" class="list-group-item list-group-item-action">Show All Mine</button>
                </form>

                <li class="list-group-item">
                    Delete
                </li>


            </ul>
        </div>


    </div>


<#--

    <div class="first-section col-md-3">


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
    </div>

    <div class="second-section col-md-7">



    </div>

    <div class="third-section col-md-2">

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

    </div>







-->






</@cmn.page>