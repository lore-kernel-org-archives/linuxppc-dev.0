To: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
Cc: acurtis@onz.com, Flavio Pereira <fpereira@azisa.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 8260 configuration 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 02 Oct 2002 09:54:34 CDT."
             <0B0A39652BB0D411BCCF00508B9512EC08AEB3FE@tx14exm05.ftw.mot.com>
Date: Wed, 02 Oct 2002 17:07:06 +0200
Message-Id: <20021002150711.6DC63FA99@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <0B0A39652BB0D411BCCF00508B9512EC08AEB3FE@tx14exm05.ftw.mot.com> you wrote:
> Is 0x0 the real physical address or logical address ? As far as

It's the  real physical address.

> Since vxWorks (5.4) has no virtual memory support and the exception
> base address is mapped to 0x0 already, starting linux kernel at 0x0
> would mean there is no exception handling capability at least at
> the very beginning.

Why not? When you copy the Linux  kernel  image  to  low  memory  you
include the Linux trap handlers, of course.

Not that they would do you any good in the very early boot stage,

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
It's hard to make a program foolproof because fools are so ingenious.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
