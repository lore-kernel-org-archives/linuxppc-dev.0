MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: ssh on ppc 405gp?
Date: Tue, 20 May 2003 08:26:52 -0400
Message-ID: <C6D44AA99ECEB540A5498F15F92DA07D6886F7@amperion01>
From: "Jeff David" <jdavid@amperion.com>
To: "Chris Zimman" <chris@cryptoapps.com>,
	"Dave Strout" <dstrout@linuxfoundary.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have seen this problem before.  It was happening a few months ago, and
hasn't happened since!

We use ssh to get to our ppc405h.  The temporary workaround for this
problem was to use a different mac protocol.  I believe the default is
2, so we tried 1, and it worked!  Here's the command:

ssh -1 192.168.25.35

Hope this works for you.

Jeff



> -----Original Message-----
> From: Chris Zimman [mailto:chris@cryptoapps.com]
> Sent: Monday, May 19, 2003 3:18 PM
> To: Dave Strout
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: ssh on ppc 405gp?
>
>
>
> On Mon, May 19, 2003 at 03:01:00PM -0400, Dave Strout wrote:
> >
> > Has anybody succeeded in getting ssh to work on a 405GP
> machine?  I've
> > checked the archives, and seen a couple of reports of
> problems, but no
> > solutions.
> >
> > I get the following error when trying to connect between a
> ppc machine
> > and an intel machine in either direction:
> >
> > Received disconnect from 192.168.1.2: 2: Corrupted MAC on input.
> >
> > If I ssh from the ppc to the ppc via 'localhost', it works.  That
> > makes me think that it's something to do with either byte
> ordering of
> > structure alignment, but I don't have any thoughts beyond
> that...  Any
> > suggestions on how to tackle this are welcome.
> >
> > thanks,
> > dave.
>
> Dave,
>
> Not sure what's going on in your case, but I've had it
> working fine for the longest time.
>
> What versions of distribution, kernel, ssh, etc. are you running?
>
> --Chris
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
