Date: Mon, 19 May 2003 14:17:56 -0500
From: Chris Zimman <chris@cryptoapps.com>
To: Dave Strout <dstrout@linuxfoundary.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: ssh on ppc 405gp?
Message-ID: <20030519191756.GA28820@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <1053370861.9594.61.camel@dstrout.nsw.enterasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1053370861.9594.61.camel@dstrout.nsw.enterasys.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 19, 2003 at 03:01:00PM -0400, Dave Strout wrote:
>
> Has anybody succeeded in getting ssh to work on a 405GP machine?  I've
> checked the archives, and seen a couple of reports of problems, but no
> solutions.
>
> I get the following error when trying to connect between a ppc machine
> and an intel machine in either direction:
>
> Received disconnect from 192.168.1.2: 2: Corrupted MAC on input.
>
> If I ssh from the ppc to the ppc via 'localhost', it works.  That makes
> me think that it's something to do with either byte ordering of
> structure alignment, but I don't have any thoughts beyond that...  Any
> suggestions on how to tackle this are welcome.
>
> thanks,
> dave.

Dave,

Not sure what's going on in your case, but I've had it working fine for
the longest time.

What versions of distribution, kernel, ssh, etc. are you running?

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
