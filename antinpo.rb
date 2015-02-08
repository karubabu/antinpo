Plugin.create(:antinpo) do
	DEFINED_TIME = Time.new.freeze
	exptmp = nil
    firstSpaces = ""
    secondSpaces = ""
	on_appear do |ms|
		ms.each do |m|
			if m.message.to_me?()
				if !m.message.from_me?()
					exptmp = m.message.to_show()

                    # @screen_nameを弾く
					exptmp = exptmp.gsub(/@[a-zA-Z0-9_]*/,'')
                    # 空の()を弾く
                    exptmp = exptmp.gsub(/[\(（][\)）]/,'')

                    # ﾌﾞﾁﾐﾘ系ではなく かつ ちんぽ系である
					if exptmp !~ /チンポモ|ちんぽも|ﾌﾞﾘ|ﾘｭﾘｭﾘｭ|ﾌﾞﾂ|ﾁﾁ|ﾐﾘ|([うおあｕｏａ]){3,}?|[!！]{10,}/ and
					   exptmp =~ /ㄘ|ち|ん|ぽ|チ|ン|ポ|ﾁ|ﾝ|ﾎ|[ｔｃｈｉｎｐｏtchinpo]{3,}/ and m[:created] > DEFINED_TIME and !m.retweet? then

				        if exptmp =~ /[ち|チ|ﾁ](\p{blank}*?)[ん|ン|ﾝ](\p{blank}*?)[ぽ|ポ|ﾎﾟ]/ then
                            firstSpaces = $1
                            secondSpaces = $2
                        end

                        exptmp = exptmp.gsub(/[ち|チ|ﾁ]/,
                                            "ち" => "な" + firstSpaces,
                                            "チ" => "ナ" + firstSpaces,
                                            "ﾁ" => "ﾅ" + firstSpaces)
                        exptmp = exptmp.gsub(/[ん|ン|ﾝ]/,
                                            "ん" => "ん" + secondSpaces,
                                            "ン" => "ン" + secondSpaces,
                                            "ﾝ" => "ﾝ" + secondSpaces)
                        exptmp = exptmp.gsub(/[ぽ|ポ|ﾎﾟ]/,
                                            "ぽ" => "で",
                                            "ポ" => "デ",
                                            "ﾎﾟ" => "ﾃﾞ")

                        # 間の空白の対応をスマートに実装できるﾋﾄはなんとかしてあげてください
                        if exptmp =~ /(c\p{blank}*?h\p{blank}*?i|ｃ\p{blank}*?ｈ\p{blank}*?ｉ|t\p{blank}*?i|ｔ\p{blank}*?ｉ)\p{blank}*?([n|ｎ|\p{blank}*?]*)(p\p{blank}*?o|ｐ\p{blank}*?ｏ)/ then
                            exptmp = exptmp.gsub(/t/, "n").gsub(/ｔ/, "ｎ")
                                           .gsub(/c/, "n").gsub(/ｃ/, "ｎ")
                                           .gsub(/h/, "").gsub(/ｈ/, "")
                                           .gsub(/i/, "a").gsub(/ｉ/, "ａ")
                                           .gsub(/p/, "d").gsub(/ｐ/, "ｄ")
                                           .gsub(/o/, "e").gsub(/ｏ/, "ｅ")
                        end
                        exptmp = exptmp.gsub(/!|！/,
                                            "!" => "?",
                                            "！" => "？")

                        hatenaLength = 140 - ("@" + m.user.idname + ' ' + exptmp).size
						Service.primary.post(:message => "#{"@" + m.user.idname + ' ' + exptmp + "？"*rand(hatenaLength)}", :replyto => m)
						m.message.favorite(true)
					end
				end
			end
		end
	end
end