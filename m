To: Dan Malek <dan@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 25 Feb 2002 18:05:41 EST."
             <3C7AC345.301@embeddededge.com>
Date: Tue, 26 Feb 2002 00:26:38 +0100
Message-Id: <20020225232643.9AB1D109E3@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C7AC345.301@embeddededge.com> Dan Malek wrote:
>
> > ....and things get even worse when you happen to use the  RISC  timers
> > for  one  or  more  PWM  channels: you'll see completely asynchronous
> > updates of PBDAT :-(
>
> Yeah, that one sucks.  Did you get a chance to try my GP Timer suggestion
> or didn't they fit the requirements?  They have dedicated I/O that doesn't

I know it would have worked, but in this case I had to  avoid  a  new
layout of the board :-(

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Minds are like parachutes - they only function when open.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
