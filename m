To: Dan Malek <dan@embeddededge.com>
Cc: David Ashley <dash@xdr.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Feb 2002 15:54:53 EST."
             <3C7AA49D.8020809@embeddededge.com>
Date: Mon, 25 Feb 2002 23:36:53 +0100
Message-Id: <20020225223658.F0448109E3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C7AA49D.8020809@embeddededge.com> you wrote:
>
> memory spaces.  A common mistake is people map things like GPIO into
> application space, and then think they can atomically update the
> registers.  This doesnt' work because there may be drivers that
> also do the same thing.

...and things get even worse when you happen to use the  RISC  timers
for  one  or  more  PWM  channels: you'll see completely asynchronous
updates of PBDAT :-(

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Engineering without management is art."               - Jeff Johnson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
