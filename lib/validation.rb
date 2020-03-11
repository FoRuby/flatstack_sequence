module Validation
  INVALID_SEQUENCE_LENGTH = 'Invalid sequence length'
  INVALID_SEQUENCE_CONTENT = 'Invalid sequence content'

  def validate_sequence!(elements:, regexp: nil, min_length: nil)
    validate_min_length(elements, min_length) if min_length
    validate_content(elements, regexp) if regexp
  end

  private

  def validate_content(elements, regexp)
    elements.each do |element|
      raise INVALID_SEQUENCE_CONTENT unless element =~ regexp
    end
  end

  def validate_min_length(elements, min_length)
    raise INVALID_SEQUENCE_LENGTH if elements.length < min_length
  end
end
