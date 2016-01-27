module AccountsHelper
  def link_to_close(account)
    link_to('Encerrar conta',
      account_close_path(account),
      :class => 'btn btn-danger btn-radio',
      method: :put,
      data: { confirm: 'Tem certeza de deseja cancelar sua conta?' },
      disable_with: "Aguarde...").html_safe
  end

  def switch_button_close(account)
    if cannot_cancel?(account)
      content_tag(:p, "Não é possivel encerrar sua conta ela possue saldo!")
    else
      link_to_close(account)
    end
  end

  def cannot_cancel?(account)
    account.has_balance?
  end
end
