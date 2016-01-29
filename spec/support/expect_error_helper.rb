module ExpectError
  module Helper
    def expect_error_on instance, collection
      method = collection[:method]
      message = collection[:message]

      method_error = instance.errors[method]

      expect(method_error.size).to eq(1) if method
      expect(method_error).to match([message]) if message
    end
  end
end