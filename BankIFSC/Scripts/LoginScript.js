$(function () {
    $('#echoSubmit').click(function () {
        var mes = $('#echo').val();
        var jsonText = JSON.stringify({ message: mes });

        $.ajax({
            type: "POST",
            url: "SampleForm.aspx/SendMessage",
            data: jsonText,
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (msg) {
                $("#messages").append(msg.d);
            }
        });
    });
});