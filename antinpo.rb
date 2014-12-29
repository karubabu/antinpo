Plugin.create(:antinpo) do
	DEFINED_TIME = Time.new.freeze
	exptmp = nil
	on_appear do |ms|
		ms.each do |m|
			if m.message.to_me?()
				if m.message.to_s =~ /ちんぽ/ and m[:created] > DEFINED_TIME and !m.retweet? then
					exptmp = m.message.to_show()
					Service.primary.post(:message => "#{"@" + m.user.idname + ' ' + exptmp + "?"*rand(40)}", :replyto => m)
					m.message.favorite(true)
				end
			end
		end
	end
end