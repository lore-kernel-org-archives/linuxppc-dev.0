To: "OTAVIO ISAMU SUGENO" <otavio.sugeno@siemens.com>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: eth0 configuration 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 29 Mar 2004 09:25:18 -0300."
             <05866645C8E0B842836A1E91B2AD6B7F0147DDA8@CUR1006V.br002.siemens.net.br>
Date: Mon, 29 Mar 2004 16:17:44 +0200
Message-Id: <20040329141749.97CAEC10A7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <05866645C8E0B842836A1E91B2AD6B7F0147DDA8@CUR1006V.br002.siemens.net.br> you wrote:
>
> I am using ELDK 3.0 in my custom board with MPC860T, instead of old
> HHL_20, and I am trying to run Linux kernel 2.4.24. I have two problems,

Did you adapt the kernel configuration for your board on the new kernel?

> perhaps someone can help me:
> 1. eth0 (FEC) does not perform link auto negotiation: FDX, HDX,
> 10/100Mbps;

Did you enable MDIO?

> 2. also IP auto config, using RARP, does not happens.

Did you enable IP Autoconfig and RARP support?

> Can anyone tell me what is happening to this functions do not be
> executed?

I guess you missed to configure the kerenl correctly for your  board,
since both features work fine on a couple of boards we tested.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Things that try to look like things often do look  more  like  things
than things. Well-known fact.       - Terry Pratchett, _Wyrd Sisters_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
