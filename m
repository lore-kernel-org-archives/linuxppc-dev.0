To: "sunrays" <lm_mailbox@sohu.com>
Cc: "Flavio Pereira" <Flavio.Pereira@za.flextronics.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Need help booting linux on my 8265 board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 19 Apr 2004 17:12:34 +0800."
             <001401c425ee$796087b0$061410ac@liu>
Date: Mon, 19 Apr 2004 12:21:53 +0200
Message-Id: <20040419102158.CA512C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001401c425ee$796087b0$061410ac@liu> you wrote:
>
> Need help booting linux on my 8265 boardHello,Mr Pereira

Can you please  STOP  posting  nearly  the  same  quesrtions  to  the
linuxppc-embedded  and  u-boot-users mailing lists? Please decide for
one list, or, if you really, really feel the message must go to  both
lists,  then  send  it  as  Cc:,  but never two separate and slightly
different messages.

>    I'm sure  IMMR base is the same for both U-boot and Linux. Uboot mapped at 0xfff00000, but I want to know why linux mapped at 0xC0000000 , the uboot say   "## Transferring control to Linux (at address 00000000) ...", so KERNELLOAD should be 0xc000000
> 0 or 0x00000000?

Welcome to the world of virtual addresses. See
http://www.denx.de/twiki/bin/view/PPCEmbedded/Kernel#Section_10.2.

>     and if I use linux kernel 2.4.20,  CONFIG_CLOCKS_IN_MHZ should be 0 or 1?

It should be not defined at all.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There are two ways to write error-free programs. Only the  third  one
works.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
