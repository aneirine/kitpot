
    <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false"
       aria-controls="collapseExample">
        Message
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
            <button type="submit" class="btn btn-primary">Save</button>
        </form>
    </div>
