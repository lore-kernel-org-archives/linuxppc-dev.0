To: "Mouloud Ameni " <mameni@caramail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Can't load linux to est8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 05 Aug 2004 10:20:21 GMT."
             <1091701221032720@lycos-europe.com>
Date: Thu, 05 Aug 2004 12:59:05 +0200
Message-Id: <20040805105910.CBEAEC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <1091701221032720@lycos-europe.com> you wrote:
>
> The "IMMR" value in the ppcboot.h is given as "0x0f000000", so i changed this value in the kernel configuration

This is broken and cannot work. Please see
http://www.denx.de/twiki/bin/view/PPCEmbedded/Kernel#Section_10.2.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
1000 pains                                              = 1 Megahertz

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
