# This email regex is the HTML5 standard from W3C. It is permissive but
# it is fine as long as we double-check email addresses another way.
EMAIL_REGEX = /^[a-zA-Z0-9.!#$%&’*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/i

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ EMAIL_REGEX
      record.errors[attribute] << (options[:message] || "is not a valid email address")
    end
  end
end
