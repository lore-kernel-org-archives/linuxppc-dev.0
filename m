Message-ID: <3814672F.598B1CBD@netx4.com>
Date: Mon, 25 Oct 1999 10:20:31 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
CC: Dan Malek <dan@penguin.netx4.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Console on SMC2 (was: Re: MPC823 Serial ports)
References: <38107697.9A2576F7@eng.uct.ac.za> <3810A961.FF50C5F8@netx4.com> <kfypuy4sz1p.fsf_-_@kieraypc01.p.y.ki.era.ericsson.se> <38133CB5.61A6433B@netx4.com> <kfyr9ijr1aj.fsf@kieraypc01.p.y.ki.era.ericsson.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Marcus Sundberg wrote:


> It would be nice if we had "Board default" as an option for
> the boot console (or as an alternative - make Config.in set
> the correct default device when you change boards).

Yeah, I know, but as I have said before, I have more than a
dozen different boards in my office, all somewhat different.
The configuration files get increasingly complex with all of these
different possibilities.  Having separate default configurations
where the only difference is the console port is kind of
overkill.  Right now, you have to know where the console port
is connected, and simply select it.  I am trying to find a simple
configuration that will work with all boards, rather than track
lots of different ones.


> I hope you will include an option to completely disable serial
> ports on SCCs without changing uart.c too?

I can easily add that.


> Well, not on any correct system running 2.1.71 or later. ;)

If you say so.  I didn't make any 8xx changes until later
releases, and the standard distribution had a symbolic link,
so I just kept that......



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
