Date: Wed, 29 Sep 1999 20:14:32 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Lou Langholtz <ldl@chpc.utah.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
In-Reply-To: <37F26FE5.98B8B00@chpc.utah.edu>
Message-ID: <Pine.LNX.3.96LJ1.1b7.990929195729.20530B-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 29 Sep 1999, Lou Langholtz wrote:

> Bummer...
> 
> I just locked up my system and had to reboot. The above change then doesn't seem
> to fix the system hangs. On the other hand I never did see the "FB. overflow"
> message at least.
> 
> I've been trying to search around HOWTOs and FAQs and mailing lists to get a
> better idea of wether nesting save_flags(flags); cli(); stuff...;
> save_flags(new_flags); cli(); restore_flags(new_flags); restore_flags(flags); is

Basically, cli() disables interrupts.  If the interrupts are disabled to
begin with, it amounts to nothing.  So, I think the nesting should cause
no harm.

> ever even ok. Haven't found anything conclusive yet though. Whatever the case, it
> doesn't seem like it'd be good practice anyhow. All the other serial support C
> files I've found so far seem to avoid this except for macserial.c.
> 


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
