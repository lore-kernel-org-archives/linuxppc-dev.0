Date: Tue, 4 Mar 2003 11:28:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Wolfgang Denk <wd@denx.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC3 UART for MPC850
Message-ID: <20030304182804.GA16123@ip68-0-152-218.tc.ph.cox.net>
References: <20030303234618.GA12721@ip68-0-152-218.tc.ph.cox.net> <20030304000335.13A00C6E0C@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030304000335.13A00C6E0C@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Mar 04, 2003 at 01:03:30AM +0100, Wolfgang Denk wrote:
>
> In message <20030303234618.GA12721@ip68-0-152-218.tc.ph.cox.net> you wrote:
> >
> > > Sorry, this is one of our patches that never  was  accepted  for  the
> > > official source trees (also including hardware flow control).
> >
> > ... because you never split things out into logical chunks which make
> > life easier on people trying to understand what changed and why.  Our
> > last merge went well I thought, and I'm up for another round if you are.
>
> It would be too much trouble to separate the  hardware  flow  control
> stuff  from the other port configuration options. I feel it should be
> sufficient to have a set of changes local to one single source file.

If you're referring to the very configurable SCC portion, as far as I
know, no one, including yourself has made a verion which satisifes all
of the people all of the time, which is why Dan hasn't approved any of
the patches to do that.  But maybe the 2.5 config language will
allow someone to write it in a manner which lets everyone do what they
want..

But, it's been a while, so if it's not too much trouble, can you send it
out again?

> You say it is not sufficent. OK. You are the maintainer, I ain't.

Dan Malek is really, I just try and help him when I can. :)

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
