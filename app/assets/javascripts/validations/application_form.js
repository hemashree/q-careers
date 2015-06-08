function validateApplicationForm() {

    jQuery.validator.addMethod("phone_format", function(value, element) {
    return /[0-9]{3}[-][0-9]{3}[-][0-9]{4}/.test( value );
    });

    $('#form_application').validate({
      debug: true,
      rules: {
        "fresher[name]": {
            required: true,
            minlength: 3,
            maxlength: 255
        },
        "fresher[email]": "required",
        "fresher[phone]": {
            required: true,
            minlength: 12,
            maxlength: 12,
            phone_format: true
        },
        "fresher[current_city]": "required",
        "fresher[native_city]": "required",
        "fresher[candidate][year_of_passing]": "required",
        "fresher[resume]": "required"
      },
      errorElement: "span",
      errorClass: "help-block",
      messages: {
        "fresher[name]": "This field is required.",
        "fresher[email]": "This field is required.",
        "fresher[phone]": {
          required: "This field is required.",
          minlength: "12 characters required including '-' (333-333-4444)",
          maxlength: "12 characters required including '-' (333-333-4444)",
          phone_format: "The phone number should be in the format of 333-333-4444."
        },
        "fresher[current_city]": "This field is required.",
        "fresher[native_city]": "This field is required.",
        "fresher[candidate][year_of_passing]": "This field is required.",
        "fresher[resume]": "This field is required."
      },
      highlight: function(element) {
          $(element).parent().parent().addClass("has-error");
      },
      unhighlight: function(element) {
          $(element).parent().parent().removeClass("has-error");
      },
      invalidHandler: function(referral, validator) {
        // 'this' refers to the form
        var errors = validator.numberOfInvalids();
        if (errors) {

          // Populating error message
          var errorMessage = errors == 1
            ? 'You missed 1 field. It has been highlighted'
            : 'You missed ' + errors + ' fields. They have been highlighted';

          // Removing the form error if it already exists
          var errorHtml = "<div class=\"alert alert-danger\" data-alert=\"alert\" style=\"margin-bottom:5px;\">"+ errorMessage +"</div>"
          $("#application_form_error").html(errorHtml);

          // Show error labels
          $("div.error").show();

        } else {
          // Hide error labels
          $("div.error").hide();

          // Removing the error message
          $("#application_form_error").remove();
        }
      },
      submitHandler: function(form) {
        if ($(form).valid())
          form.submit();
        return false; // prevent normal form posting
      }

    });

}
