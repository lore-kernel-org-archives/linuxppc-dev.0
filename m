To: "Ian Guffick" <zenadsl2546@zen.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MCF5200 Dev Environment 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 24 Nov 2003 09:28:01 GMT."
             <001501c3b26d$459555e0$0d01a8c0@IAN>
Date: Mon, 24 Nov 2003 11:24:28 +0100
Message-Id: <20031124102433.C4387C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001501c3b26d$459555e0$0d01a8c0@IAN> you wrote:
>
> What GNU tools are available for the Motorola MCF5200 PowerPC processor.

We use the ppc_82xx packages of our ELDK which is available for free download.

> I presume somewhere there will be GCC, GDB, and all the other useful stuff ?

Sure. See http://www.denx.de/twiki/bin/view/DULG/ELDK for details.

> What tools exist for programming/debugging a board without dBug preloaded into flash ?

BDI2000.

> P.S. I want to avoid paying £5000 for a dev kit with Code Warrior or Green Hills or similar.
> Thanks for any pointers in the right direction  ;-)

If you are going to do any serious work (kernel / driver development)
you will want a BDI2000 rather sooner than later anyway ;-)

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Until you walk a mile in another man's moccasins, you  can't  imagine
the smell.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
