To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC3 UART for MPC850 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 03 Mar 2003 16:46:18 MST."
             <20030303234618.GA12721@ip68-0-152-218.tc.ph.cox.net>
Date: Tue, 04 Mar 2003 01:03:30 +0100
Message-Id: <20030304000335.13A00C6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030303234618.GA12721@ip68-0-152-218.tc.ph.cox.net> you wrote:
>
> > Sorry, this is one of our patches that never  was  accepted  for  the
> > official source trees (also including hardware flow control).
>
> ... because you never split things out into logical chunks which make
> life easier on people trying to understand what changed and why.  Our
> last merge went well I thought, and I'm up for another round if you are.

It would be too much trouble to separate the  hardware  flow  control
stuff  from the other port configuration options. I feel it should be
sufficient to have a set of changes local to one single source file.

You say it is not sufficent. OK. You are the maintainer, I ain't.

It's your decision, and I won't discuss it.


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Most people would like to be delivered  from  temptation  but  would
like it to keep in touch."                             - Robert Orben

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
