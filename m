To: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Basic Config file 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 24 Apr 2003 16:00:06 EDT."
             <3EA84246.9050101@catapult.com>
Date: Thu, 24 Apr 2003 22:18:31 +0200
Message-Id: <20030424201836.56798C5E29@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3EA84246.9050101@catapult.com> you wrote:
>
> Read the ELDK manual, however, did not see anything
> on the kernel configuration and building it.  Went to
> kernelnewbies for that...anywhere else I can go for
> kernel configuration.

There is also  http://www.denx.de/re/DPLG.html  (but  this  does  not
answer the details of kernel configuration - it only describes how to
use  existing  default  configs). In all other cases you just have to
know what you are doing.

> Unresolveds are:
> va_to_pte and get_IMMR in traps.c
> the get_IMMR seems to be 8xx specific.
> va_to_pte is in several headers for asm code,
> but grep of the source tree does not show any
> implementations in *.[Sch]

It's a bug. Both EXPORT_SYMBOL()s are  8xx  specific.  Fixed  in  our
current CVS.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A dog always bit deepest on the veterinary hand.
                                    - Terry Pratchett, _Wyrd Sisters_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
