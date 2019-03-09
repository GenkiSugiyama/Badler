if @new_message.present? # @new_messageに中身があれば
  json.array! @new_message # 配列かつjson形式で@new_messageを返す
end