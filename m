To: Meriin Michael-BMM063 <Meriin@motorola.com>
Cc: Estevam Fabio-R49496 <Fabio.Estevam@freescale.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Internal Address multiplexing for MCP852 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 30 May 2004 10:42:36 +0300."
             <0F48024310E5D6118D200002B3A440DB08B07A15@zil01exm08.mcil.comm.mot.com>
Date: Tue, 01 Jun 2004 01:57:01 +0200
Message-Id: <20040531235706.1BA37C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <0F48024310E5D6118D200002B3A440DB08B07A15@zil01exm08.mcil.comm.mot.com> you wrote:
>
> I hope you are using U-boot as a bootloader.
> So just try this SDRAM init (see attachment).

Seemes you removed some code, including the write to the  mamr  which
enables  the  refresh? The while init sequence seams a bit simplified
to me - are you sure about this?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I mean, I . . . think to understand you, I just don't know  what  you
are saying ...                        - Terry Pratchett, _Soul Music_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
