module ExpectError
  module Helper
    def expect_error_on method
      expect(account.errors[method].size).to eq(1)
    end
  end
end