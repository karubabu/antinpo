Plugin.create(:antinpo) do
	DEFINED_TIME = Time.new.freeze
	exptmp = nil
	on_appear do |ms|
		ms.each do |m|
			if m.message.to_me?()
				if !m.message.from_me?()
					if m.message.to_s =~ /ﾌﾞﾘ|ﾘｭﾘｭﾘｭ|ﾌﾞﾂ|ﾁﾁ|ﾐﾘ|([うおあｕｏａ]){3,}?|[!！]{10,}/ and m[:created] > DEFINED_TIME and !m.retweet? then
					elsif m.message.to_s =~ /ちんぽ/ and m[:created] > DEFINED_TIME and !m.retweet? then
						exptmp = m.message.to_show()
						exptmp = exptmp.gsub(/@.*\s/,'')
						exptmp = exptmp.gsub(/ちんぽ/,'なんで')
						exptmp = exptmp.gsub(/!|！/,'？')
						Service.primary.post(:message => "#{"@" + m.user.idname + ' ' + exptmp + "？"*rand(30)}", :replyto => m)
						m.message.favorite(true)
					end
				end
			end
		end
	end
end