Date: Fri, 17 Sep 1999 15:14:05 -0500
From: Shaw Terwilliger <sterwill@io.nu>
To: "David A. Gatwood" <dgatwood@mvista.com>
Cc: Josh Huber <huberj@wpi.edu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard shuts itself off
Message-ID: <19990917151405.A13268@io.nu>
References: <19990917103225.A12534@io.nu> <Pine.LNX.3.96.990917102529.5903D-100000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.990917102529.5903D-100000@mvista.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David A. Gatwood wrote:
> On Fri, 17 Sep 1999, Shaw Terwilliger wrote:
> > Yes, it's just like like the battery got yanked out (which I've done
> > once; just once!  The Lombards have that bay release lever in the
> > ultimate "shirt-catching" position).  I know both times the machine
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Same thing on the WallStreet.  And I thought I was the only one who found
> that obnoxious.  :-)

I'm now very careful how I move it around in my lap.  I
subconsciously move it in planes parallel to the lie of
the lever in the rest position, picking it up to move it
perpendicular as necessary.  :)

> Did you remove the cord from the back or just the wall?

I'm always removing the cord from the back of the machine,
never from the wall.

> Assuming it's like the wallstreet in this regard, the lights stay on while
> the battery is charging to indicate the charge status.  As soon as it
> finishes charging, they go off.

That's what I was guessing it was doing, but it doesn't always
stick to this plan, so I was confused.

> Again, based on the wallstreet's behaviour, sometimes the battery gets
> confused. Eject the battery and reinsert it (leave the power cord plugged
> in so your machine doesn't die) and it should probably figure out what's
> going on.

Yeah... I had a wacky idea today:  Maybe when I unplugged the
machine from its wall supply, the battery had worked its way
either (1) away from the contacts inside the bay or (2) into a
state of denial, where it was fully in the bay but the machine
didn't know it.  In this case, perhaps the PowerBook can handle
five minutes on a small internal battery before dying.  I figure
if I was the one implementing this feature I'd throw a message
to the operating system that you had a short period of time to
get power back (like putting in a new battery)... being that Linux
isn't getting any support or attention from the PMU people maybe
it's doing this.  This would be a great feature for someone
swapping batteries while keeping the machine on (and while away
from an outlet, like on a plane) but would add lots to the
weight and cost, I'd think.

This is just a wild guess on my part, and Ben or Paul probably know
much more about this than I do, but it's almost consistent with
the situation, given that this magical internal battery exists.  :)

-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
