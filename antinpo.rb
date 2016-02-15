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
		exptmp.gsub! /ﾃｨ/, "ﾅｧ"
		exptmp.tr! "ちチﾁㄘぽポ", "ななナﾅでデ"
		exptmp.gsub! /ﾎﾟｩ/, "ﾃﾞｪ"
		exptmp.gsub! /ﾎﾟ/,"ﾃﾞ"
		# 間の空白の対応をスマートに実装できるﾋﾄはなんとかしてあげてください
		exptmp.tr! "ctinpoCTINPOｃｔｉｎｐｏ", "nnandeNNANDEｎｎａｎｄｅ"
		exptmp.gsub! /[hHｈ]/, ""

		exptmp.tr! "!！", "?？"
		return exptmp
	end

	def omaenakataka?(m)
		if m.message.to_me?()
			if !m.message.from_me?()
				return true
			end
		end

		return false;
	end

	def zenngi(m)
		exptmp = m.message.to_show()
		# @screen_nameを弾く
		exptmp = exptmp.gsub(/@[0-9a-zA-Z_]+[\s　]*/, '')
		# 空の()を弾く
		exptmp = exptmp.gsub(/[\(（][\)）]/,'')
		exptmp = exptmp.gsub(/(https?|ftp):\/\/[\/A-Za-z0-9\.\p{blank}]*/,'')
		exptmp = exptmp.gsub(/\p{blank}+?/,'')

		return exptmp;
	end

	def tinpoCheck(m,str)
		if str !~ /チンポモ|ちんぽも|ﾌﾞﾘ|ﾘｭﾘｭﾘｭ|ﾌﾞﾂ|ﾁﾁ|ﾐﾘ|ﾌﾞ|([うおあｕｏａioOIAU]){5,}?|[!！]{10,}/ and
			str =~ /[ㄘちんぽチンポﾁﾝﾎﾟ]{3,}|[TINMPOｔｃｉｎｍｐｏtcinmpo]{4,}|(チン|ちん|ﾁﾝ)([^でデﾃﾞ]+)/ and m[:created] > DEFINED_TIME and !m.retweet? and m.message.to_s !~ /[\(（]@karubabu[\)）]/ then
			return true
		end

		return false
	end

	on_appear do |ms|
		ms.each do |m|
			if omaenakataka?(m)
				#ちんぽチェック前の整形実質前戯でしょ
				checktmp = zenngi(m)

				# ﾌﾞﾁﾐﾘ系ではなく かつ ちんぽ系である
				if tinpoCheck(m,checktmp)
					tweet = tinpoConverter(checktmp)
					delaytweet(m,tweet,8)
				end

			end
		end
	end

end
