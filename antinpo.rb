Plugin.create(:antinpo) do

DEFINED_TIME = Time.new.freeze
exptmp = nil
checktmp = nil

	def delaytweet(m,tweet,hatenaLength)
		m.message.favorite(true)
		Reserver.new((tweet.size)/2){
			Service.primary.post(:message => "#{"@" + m.user.idname + ' ' + tweet + "？"*rand(hatenaLength)}", :replyto => m)
		}
	end

	def tinpoConverter(exptmp)
		#ほんと誰かいい方法考えて
		exptmp = exptmp.gsub(/ち|チ|ﾁ|ㄘ|ﾃｨ/,
			"ㄘ" => "な",
			"ち" => "な",
			"チ" => "ナ",
			"ﾁ" => "ﾅ",
			"ﾃｨ" => "ﾅｧ")
		exptmp = exptmp.gsub(/ん|ン|ﾝ/,
			"ん" => "ん",
			"ン" => "ン",
			"ﾝ" => "ﾝ")
		exptmp= exptmp
		.gsub(/ぽ/,"で")
		.gsub(/ポ/,"デ")
		.gsub(/ﾎﾟ^ｩ/,"ﾃﾞ")
		.gsub(/ﾎﾟｩ/,"ﾃﾞｪ")
		# 間の空白の対応をスマートに実装できるﾋﾄはなんとかしてあげてください
		exptmp = exptmp.gsub(/t/, "n").gsub(/ｔ/, "ｎ").gsub(/T/, "N")
		.gsub(/c/, "n").gsub(/ｃ/, "ｎ").gsub(/C/, "N")
		.gsub(/h/, "").gsub(/ｈ/, "").gsub(/H/, "")
		.gsub(/i/, "a").gsub(/ｉ/, "ａ").gsub(/I/, "A")
		.gsub(/p/, "d").gsub(/ｐ/, "ｄ").gsub(/P/, "D")
		.gsub(/o/, "e").gsub(/ｏ/, "ｅ").gsub(/O/, "E")

		exptmp = exptmp.gsub(/!|！/,
		"!" => "?",
		"！" => "？")

		return exptmp
	end

	on_appear do |ms|
		ms.each do |m|
			if m.message.to_me?()
				if !m.message.from_me?()
					exptmp = m.message.to_show()
					# @screen_nameを弾く
					exptmp = exptmp.gsub(/@[a-zA-Z0-9_]*\p{blank}?/,'')
					# 空の()を弾く
					exptmp = exptmp.gsub(/[\(（][\)）]/,'')
					exptmp = exptmp.gsub(/(https?|ftp):\/\/[\/A-Za-z0-9\.\p{blank}]*/,'')
					checktmp=exptmp
					checktmp = checktmp.gsub(/\p{blank}+?/,'')
					# ﾌﾞﾁﾐﾘ系ではなく かつ ちんぽ系である
					if checktmp !~ /チンポモ|ちんぽも|ﾌﾞﾘ|ﾘｭﾘｭﾘｭ|ﾌﾞﾂ|ﾁﾁ|ﾐﾘ|([うおあｕｏａio]){5,}?|[!！]{10,}/ and
						checktmp =~ /[ㄘちんぽチンポﾁﾝﾎﾟ]{3,}|[TINPOｔｃｉｎｐｏtcinpo]{4,}|(チン|ちん|ﾁﾝ)([^でデﾃﾞ]+)/ and m[:created] > DEFINED_TIME and !m.retweet? then

						exptmp=tinpoConverter(exptmp)
						delaytweet(m,exptmp,5)
					end
				end
			end
		end
	end
end