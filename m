To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Disabling data cache 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 03 Apr 2003 07:59:06 PDT."
             <20030403145906.GA3867@ip68-0-152-218.tc.ph.cox.net>
Date: Sat, 05 Apr 2003 00:49:51 +0200
Message-Id: <20030404224956.A53C4C587C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030403145906.GA3867@ip68-0-152-218.tc.ph.cox.net> you wrote:
>
> > It might have been me. We had problems on  the  first  prototypes  of
> > TQM8260 boards; the board configuration with L2 cache would only work
> > with  DC turned off. The problem disappeared with later silicon, so I
> > never checked again what happened with the code.
>
> So the question now is do you still care about this case, or can it go
> away in the public tree?

I don't care. Nobody buys such old hardware any more.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Every little picofarad has a nanohenry all its own.      - Don Vonada

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
