Plugin.create(:antinpo) do
	DEFINED_TIME = Time.new.freeze
	exptmp = nil
	on_appear do |ms|
		ms.each do |m|
			if m.message.to_me?()
				if !m.message.from_me?()
					exptmp = m.message.to_show()
					exptmp = exptmp.gsub(/͏/,'')
					exptmp = exptmp.gsub(/@.*\s/,'')
					exptmp = exptmp.gsub(/[\(（]@.*[\)）]/,'')
					exptmp = exptmp.gsub(/[:blank:]/,'')
					if exptmp =~ /ちんぽも|ﾌﾞﾘ|ﾘｭﾘｭﾘｭ|ﾌﾞﾂ|ﾁﾁ|ﾐﾘ|([うおあｕｏａ]){3,}?|[!！]{10,}/ and m[:created] > DEFINED_TIME and !m.retweet? then
					elsif exptmp =~ /ちんぽ/ and m[:created] > DEFINED_TIME and !m.retweet? then
						exptmp = exptmp.gsub(/ちんぽ/,'なんで')
						exptmp = exptmp.gsub(/!|！/,'？')
						Service.primary.post(:message => "#{"@" + m.user.idname + ' ' + exptmp + "？"*rand(20)}", :replyto => m)
						m.message.favorite(true)
					elsif exptmp =~ /ちん([^で]*)?|(ちん){2,}|(ㄘん){2,}|ㄘん([^で]*)?|[cｃtinpoｔｉｎｐｏ]{5,}/ and m[:created] > DEFINED_TIME and !m.retweet? then
						exptmp = exptmp.gsub(/tinpo|cinpo/,'nande')
						exptmp = exptmp.gsub(/ｔｉｎｐｏ|ｃｉｎｐｏ/,'ｎａｎｎｄｅ')
						exptmp = exptmp.gsub(/ちん/,'なん')
						exptmp = exptmp.gsub(/!|！/,'？')
						Service.primary.post(:message => "#{"@" + m.user.idname + ' ' + exptmp + "？"*rand(20)}", :replyto => m)
						m.message.favorite(true)
					end
				end
			end
		end
	end
end