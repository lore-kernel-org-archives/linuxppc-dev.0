To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Console on SMC2 (was: Re: MPC823 Serial ports)
References: <38107697.9A2576F7@eng.uct.ac.za> <3810A961.FF50C5F8@netx4.com> <kfypuy4sz1p.fsf_-_@kieraypc01.p.y.ki.era.ericsson.se> <38133CB5.61A6433B@netx4.com> <kfyr9ijr1aj.fsf@kieraypc01.p.y.ki.era.ericsson.se> <3814672F.598B1CBD@netx4.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 25 Oct 1999 16:59:37 +0200
In-Reply-To: Dan Malek's message of "Mon, 25 Oct 1999 10:20:31 -0400"
Message-ID: <kfyiu3vqyee.fsf@kieraypc01.p.y.ki.era.ericsson.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek <dan@netx4.com> writes:

> Marcus Sundberg wrote:
> 
> 
> > It would be nice if we had "Board default" as an option for
> > the boot console (or as an alternative - make Config.in set
> > the correct default device when you change boards).
> 
> Yeah, I know, but as I have said before, I have more than a
> dozen different boards in my office, all somewhat different.
> The configuration files get increasingly complex with all of these
> different possibilities.  Having separate default configurations
> where the only difference is the console port is kind of
> overkill.  Right now, you have to know where the console port
> is connected, and simply select it.  I am trying to find a simple
> configuration that will work with all boards, rather than track
> lots of different ones.

Yes, that is the right way to go for the distribution kernel.
Howver, we have several different boards here too, and personally
I'd perfer if I could just select the CPU and board type at
configuration time, and have the rest taken from my board specific
file. This could be allowed even if the board files in the
distribution doesn't use this feature.

//Marcus
-- 
-------------------------------+------------------------------------
        Marcus Sundberg        | http://www.stacken.kth.se/~mackan/
 Royal Institute of Technology |       Phone: +46 707 295404
       Stockholm, Sweden       |   E-Mail: mackan@stacken.kth.se

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
