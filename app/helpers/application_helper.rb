module ApplicationHelper
  # フラッシュメッセージをリアルタイム表示するための部分テンプレートを用意する
  def flash_template(flash)
    ApplicationController.renderer.render partial: "shared/flash_messages", locals: { flash: flash }
  end
end
