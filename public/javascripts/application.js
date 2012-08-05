
$.fn.deleteAction = function(link) {
    var form = $("<form method='post' style='display:none'></form>");

    form.attr("action", $(link).attr('href'));
    $("<input type='hidden'/>").attr("name", "_method")
                             .attr("value", "delete")
                             .appendTo(form);

    $("<input type='hidden'/>").attr("name", "authenticity_token")
                             .attr("value", AUTH_TOKEN)
                             .appendTo(form);
    
    $("body").append(form);

    form.trigger("submit");
};


$(function() {
  $("#sign_out_link").click(function(){ $.fn.deleteAction(this); return false });
});
