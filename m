Date: Wed, 17 May 2000 08:04:41 -0700 (MST)
From: Tim Wojtulewicz <Tim.Wojtulewicz@NAU.EDU>
Subject: Re: Pismo status
In-reply-to: <39226066.BF822A70@mpifr-bonn.mpg.de>
To: linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Message-id: <Pine.SOL.3.95.1000517080150.18633B-100000@dana.ucc.nau.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 May 2000, Albrecht [iso-8859-1] Dreß wrote:

> Tim Wojtulewicz wrote:
> > No it's definitely supposed to have a fan.  It comes on in MacOS.
> > The problem is that the PMU is not fully supported yet, so it doesn't
> > understand that the processor is too hot.  I'm trying to find
>                       ^^^^^^^^^^^^^^^^^^^^
> Does this mean that I can damage the machine if I just run a high-load
> program?!?

There won't be any damage to the machine.  The problem is that when the
processor reaches a certain temperature (one that is above limits) it puts
out a halt instruction.  This causes the machine to lock up.  The
protection against overheating is built into the processor (last time I
checked).  What should happen is that the OS should realize that the
processor is getting too warm, and turn on the fan before that limit is
reached.  Unfortunately, the temperature sensing code doesn't work so
well (or maybe something else), and the fan never comes on.

Don't worry about the machine, somewhere I heard the plastic case can
handle around 250 degrees F, so it's not in any danger of melting.

Tim


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
