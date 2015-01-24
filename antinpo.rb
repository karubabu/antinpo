Plugin.create(:antinpo) do
	DEFINED_TIME = Time.new.freeze
	exptmp = nil
	on_appear do |ms|
		ms.each do |m|
			if m.message.to_me?()
				if !m.message.from_me?()
					exptmp = m.message.to_show()
					exptmp = exptmp.gsub(/[\(（].*?@.*?[\)）]/,'')
					exptmp = exptmp.gsub(/@.*?\p{blank}/,'')
					exptmp = exptmp.gsub(/\p{blank}+/,'')
					exptmp = exptmp.gsub(/͏/,'')
					if exptmp =~ /チンポモ|ちんぽも|ﾌﾞﾘ|ﾘｭﾘｭﾘｭ|ﾌﾞﾂ|ﾁﾁ|ﾐﾘ|([うおあｕｏａ]){3,}?|[!！]{10,}/ and m[:created] > DEFINED_TIME and !m.retweet? then
					elsif exptmp =~ /[ちチﾁ](\p{blank}*?)[んンﾝ](\p{blank}*?)[ぽポﾎﾟ]/ and m[:created] > DEFINED_TIME and !m.retweet? then
						exptmp = exptmp.gsub(/ち(\p{blank}*?)ん(\p{blank}*?)ぽ/,'な' + $1 +'ん' + $2 + 'で')
						exptmp = exptmp.gsub(/チ(\p{blank}*?)ン(\p{blank}*?)ポ/,'ナ' + $1 +'ン' + $2 + 'デ')
						exptmp = exptmp.gsub(/ﾁ(\p{blank}*?)ﾝ(\p{blank}*?)ﾎﾟ/,'ﾅ' + $1 +'ﾝ' + $2 + 'ﾃﾞ')
						exptmp = exptmp.gsub(/ぽ/,'で')
						exptmp = exptmp.gsub(/ポ/,'デ')
						exptmp = exptmp.gsub(/ﾎﾟ/,'ﾃﾞ')
						exptmp = exptmp.gsub(/!|！/,'？')
						Service.primary.post(:message => "#{"@" + m.user.idname + ' ' + exptmp + "？"*rand(20)}", :replyto => m)
						m.message.favorite(true)
					elsif exptmp =~ /(チン|ㄘん|ちん|ﾁﾝ){2,}|(チン|ㄘん|ちん|ﾁﾝ)([^でデﾃﾞ]+?)|[cｃtinpoｔｉｎｐｏ]{5,}/ and m[:created] > DEFINED_TIME and !m.retweet? then
						exptmp = exptmp.gsub(/tinpo|cinpo/,'nande')
						exptmp = exptmp.gsub(/ｔｉｎｐｏ|ｃｉｎｐｏ/,'ｎａｎｎｄｅ')
						exptmp = exptmp.gsub(/ちん/,'なん')
						exptmp = exptmp.gsub(/ㄘん/,'なん')
						exptmp = exptmp.gsub(/チン/,'ナン')
						exptmp = exptmp.gsub(/ﾁﾝ/,'ﾅﾝ')
						exptmp = exptmp.gsub(/ぽ/,'で')
						exptmp = exptmp.gsub(/ポ/,'デ')
						exptmp = exptmp.gsub(/ﾎﾟ/,'ﾃﾞ')
						exptmp = exptmp.gsub(/!|！/,'？')
						Service.primary.post(:message => "#{"@" + m.user.idname + ' ' + exptmp + "？"*rand(20)}", :replyto => m)
						m.message.favorite(true)
					end
				end
			end
		end
	end
end