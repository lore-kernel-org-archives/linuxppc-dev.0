To: Tom Rini <trini@kernel.crashing.org>
Cc: Song Sam <samlinuxppc@yahoo.com.cn>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Boot time with several filesystems on RPXlite DW 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 10 Aug 2004 14:47:57 PDT."
             <20040810214757.GL22109@smtp.west.cox.net>
Date: Wed, 11 Aug 2004 00:39:12 +0200
Message-Id: <20040810223917.AC0ABC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040810214757.GL22109@smtp.west.cox.net> you wrote:
>
> Try trimming down the .config.  For example, it doesn't look like you
> need IP_PNP enabled as you aren't NFSrooting and can just bring the
> interface up later.

This depends. If the application needs network access, it is  usually
faster  to  use  IP_PNP  instead  of loading and running ifconfig and
route. [At least under 2.4; don't know timings for 2.6.]

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I am a computer. I am dumber than any human and smarter than any  ad-
ministrator.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
