Plugin.create(:antinpo) do
	DEFINED_TIME = Time.new.freeze
	exptmp = nil
	on_appear do |ms|
		ms.each do |m|
			if m.message.to_me?()
				if !m.message.from_me?()
					exptmp = m.message.to_show()
					exptmp = exptmp.gsub(/͏/,'')#なのはがやってきた謎の文字を消す
					exptmp = exptmp.gsub(/@.*\s/,'')#リプライしてきた人のIDを消す
					exptmp = exptmp.gsub(/[\(（]@.*[\)）]/,'')#"(@karubabu)"とかしてくるのを消す
					exptmp = exptmp.gsub(/ |　/,'')#空白文字を消す
					exptmp = exptmp.gsub(/!|！/,'？')
					exptmp = exptmp.gsub(/ちんぽも?/,'なんで')
					exptmp = exptmp.gsub(/tinpo|cinpo/,'nande')
					exptmp = exptmp.gsub(/ｔｉｎｐｏ|ｃｉｎｐｏ/,'ｎａｎｄｅ')
					exptmp = exptmp.gsub(/ちんで?/,'なん')
					exptmp = exptmp.gsub(/ㄘんで?/,'なん')
					if exptmp =~ /ﾌﾞﾘ|ﾘｭﾘｭﾘｭ|ﾌﾞﾂ|ﾁﾁ|ﾐﾘ|([うおあｕｏａ]){5,}?|[!！]{10,}/ and m[:created] > DEFINED_TIME and !m.retweet? then
					elsif exptmp =~ /なんで|なん([.+^で])?|(なん){2,}|[nadeｎａｄｅ]{4,}/ and m[:created] > DEFINED_TIME and !m.retweet? then
						Service.primary.post(:message => "#{"@" + m.user.idname + ' ' + exptmp + "？"*rand(20)}", :replyto => m)
						m.message.favorite(true)
					end
				end
			end
		end
	end
end