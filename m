From: Ryan Nielsen <ran@krazynet.com>
Message-ID: <19990123010552.A182@gondolin>
Date: Sat, 23 Jan 1999 01:05:52 -0800
To: Troy Benjegerdes <hozer@drgw.net>
Cc: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au
Subject: Re: kswapd and SMP still broke on 2.2.0-pre9
References: <199901230259.NAA17964@tango.anu.edu.au> <Pine.LNX.4.04.9901222349480.17601-100000@narn.local.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.04.9901222349480.17601-100000@narn.local.drgw.net>; from Troy Benjegerdes on Fri, Jan 22, 1999 at 11:54:16PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Troy Benjegerdes wrote:
> 
> On Sat, 23 Jan 1999, Paul Mackerras wrote:
> 
> > Troy Benjegerdes <hozer@drgw.net> wrote:
> > 
> > > kswapd is still dieing on boot with SMP enabled (and this time the second
> > > processor is actually active)
> > > 
> > > Does this indicate something is wrong with SMP and the MM code, or that
> > > some PPC-specific part needs fixing? I've tried to keep up on
> > > linux-kernel, but it's a little overwhelming ;)
> > 
> > The SMP stuff in Linux/PPC currently only supports the Apple MP
> > architecture (I think they call it "powersurge").  Your MTX board
> > probably has entirely different ways of coordinating the CPUs.  Have
> > you looked at arch/ppc/kernel/smp.c?  I think that's where you'd have
> > to start changing things.
> 
> This is true, and I need to finish stuff in smp.c, but the same crash
> occured from 2.2.0-pre5 on, without the second CPU being active. Patching
> the kswapd portion of back to 2.2.0-pre4 fixed this.. Look for a message
> in the archives from Ryan Nielson, I believe.
> 
> Can anyone verify 2.2.0-pre9 works on a SMP Pmac? (or for that matter,
> vger.. if vger works I can figure out what changed)

vger-pre8 and 2.2.0-pre9 dont work.
on an Apple 9600/200MP.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
