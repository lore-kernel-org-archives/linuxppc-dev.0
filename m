Date: Wed, 30 Jun 1999 08:46:35 -0500 (CDT)
From: Kevin Puetz <kp11901@mail.cedarnet.org>
To: Eric Dorland <dorland@lords.com>
cc: Kevin Puetz <puetz@penguinpowered.COM>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Problems with the atyfb driver on Power Mac G3
In-Reply-To: <l03130302b39f629aff60@[209.226.106.187]>
Message-ID: <Pine.SGI.3.95.990630084239.6543C-100000@www.cedarnet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


nOn Wed, 30 Jun 1999, Eric Dorland wrote:

> >1st thing for both of you (and other users) - STAY AWAY FROM 2.3.x UNLESS
> >YOU KNOW WHY YOU ARE MOVING TO IT!
> 
> I don't use them. I just booted with 2.3.6 once because it contained the
> latest atyfb driver, to see if it would help. It didn't.

Geert suggested just moving atyfb.c from 2.3.6 into 2.2.10 - that is
definately less risky. But when Linus says developmental release, it
means this version would never have left the project team in a normal
software company.

> >On a happier note, I checked out 2.2.10 today (use -rlinux_2_2 if you use
> >cvs to switch branches), and built it, and the dancing pixels and other
> >artifacts are gone (on a rev 1 G3 desktop with Rage II+, but I had the same
> >symptoms, so maybe the same fix will help).
> 
> I'm glad someone's having some luck :) What settings is the kernel
> reporting (mlck, pll, etc.)?

67/200 (I think, from memory) but this is a Rage II+ not a Rage Pro (It's
a rev 1 box) so the values may not apply to your situation well.

> >I think 2.2.10 has the mach64 work from 2.3.6 backported into it w/o the
> >other potential problems
> 
> I don't think the stock 2.2.10 kernel has the latest drivers in it, but you
> can drop the atyfb.c file from 2.3.6 into a 2.2.10 tree and it should
> compile without problems. I believe someone has a precompiled kernel that
> is like this. I use the 2.2.10 kernel everyday, but the snow persists.

Hmm... it went away for me. Want the vmlinux? I can send it to you if you
want (not that it should be any different than one you built, but...). It
has pretty much normal config+mac-on-linux patches.

> Eric Dorland
> mailto:dorland@lords.com
> 
> 

Kevin Puetz <kp11901@www.cedarnet.org>



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
