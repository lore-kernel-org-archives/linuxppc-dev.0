To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Disabling data cache 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 02 Apr 2003 12:46:22 PDT."
             <20030402194622.GA30107@ip68-0-152-218.tc.ph.cox.net>
Date: Wed, 02 Apr 2003 22:19:09 +0200
Message-Id: <20030402201914.6C7F2C587C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030402194622.GA30107@ip68-0-152-218.tc.ph.cox.net> you wrote:
>
> > It was orginally done for 8xx processors.  I suspect someone (I don't
> > think it was me) :-) tried to consolidate 8xx and 82xx CPM configurations
> > and messed it up.
>
> My guess and recollection is that the 8260 version of this was to
> disable the DCACHE in a certain manner, because of buggy silicon on a
> specific board.  Someone unmerged this bit of code later I think.

It might have been me. We had problems on  the  first  prototypes  of
TQM8260 boards; the board configuration with L2 cache would only work
with  DC turned off. The problem disappeared with later silicon, so I
never checked again what happened with the code.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Intel told us the Pentium would have "RISK" features...

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
