To: "OTAVIO ISAMU SUGENO" <otavio.sugeno@siemens.com>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: eth0 configuration 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 29 Mar 2004 11:42:07 -0300."
             <05866645C8E0B842836A1E91B2AD6B7F0147DDA9@CUR1006V.br002.siemens.net.br>
Date: Tue, 30 Mar 2004 10:05:44 +0200
Message-Id: <20040330080549.D2A96C116F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <05866645C8E0B842836A1E91B2AD6B7F0147DDA9@CUR1006V.br002.siemens.net.br> you wrote:
>
> When kernel is going up, FEC is configured correctly. I see message
> below:
>
> ttyS0 at 0x0100 is on SCC2 usipty: 256 Unix98 ptys configured
> eth0: FEC ENET Version 0.3, FEC irq 9, with MDIO, MII irq 12, addr 08:00:06:59:af:4f

Did you check if the interrupts (FEC, MII) are really correct?

> But no eth0 autonegotiation ou RARP requests.

Feel free to send me your kernel config file and the _complete_  boot
log. I still think you might have a config problem.

> I am trying to find where these functions are called. Can you tell me
> are they are initialized.

grep the source tree?


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There are three things I always forget. Names, faces -  the  third  I
can't remember.                                         - Italo Svevo

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
