To: Dan Malek <dan@mvista.com>
Cc: jtm@smoothsmoothie.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 console problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 22 Feb 2001 14:13:00 EST."
             <3A9564BC.D8C08CA5@mvista.com>
Date: Thu, 22 Feb 2001 20:24:14 +0100
Message-Id: <20010222192419.6B737281D9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3A9564BC.D8C08CA5@mvista.com> Dan Malek wrote:
>
> > It  seems  you  forgot  to  modify   the   "bd_info"   structure   in
> > "include/asm-ppc/est8260.h""  to  match  the  definition as passed by
> > PPCBoot.
>
> ...and you will have to modify arch/ppc/mbxboot/embed_config.c because
> the 8260 may not expect a boot rom to hand it a bd_info.  I don't
> remember how I left it......it may just fill in some hard coded values.

I don't think so.

PPCBoot does not use _anything_ from the stuff in arch/ppc/mbxboot/

>From the PPCBoot point of view, all this stuff is obsolete.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Chapter 1 -- The story so  far:
In the beginning the Universe was created. This has  made  a  lot  of
people very angry and been widely regarded as a bad move.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
