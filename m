Message-Id: <l03130302b3a0940e99c0@[216.67.44.31]>
In-Reply-To: <01JCZKMNZI508X05JV@uni.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 30 Jun 1999 23:54:28 -0400
To: Kevin Puetz <puetz@penguinpowered.COM>
From: "Michael R. Zucca" <mrz5149@acm.org>
Subject: Re: Problems with the atyfb driver on Power Mac G3
Cc: Eric Dorland <dorland@lords.COM>, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 10:58 PM -0400 6/29/99, Kevin Puetz wrote:

>this is a _developmental_ branch.

As a past contributor and somebody who does this professionally, I
understand the risks and am happily walking on the hot coals of my own
volition. Thanks for the tip, though :-)

>Now, the ? files are not a sign of already done damage. They are harmless
>(created by a bug in gmc, the gnome file manager) and can be deleted or
>ignored.

I didn't know this as I've never had any experience with GNOME. That is one
nasty little bug, though. Those files can be quite the pain to get rid of.

>On a happier note, I checked out 2.2.10 today (use -rlinux_2_2 if you use
>cvs to switch branches), and built it, and the dancing pixels and other
>artifacts are gone (on a rev 1 G3 desktop with Rage II+, but I had the same
>symptoms, so maybe the same fix will help).

I think 2.2.10's driver is just the 2.3.6 driver code. It may be working
for you out of sheer luck or perhaps the fix was enough for Rage II+. The
problem persists on my Rage Pro.

>I think 2.2.10 has the mach64 work from 2.3.6 backported into it w/o the
>other potential problems

Well, as far as I can tell the 2.3.6 fb code only partially solves the
problem. We probe for the MCLK now but perhaps we should also probe for PLL
clock (are we already?). Can't we just get these values from OF? I thought
I saw an entry in the card's device tree for such stuff.

_______________________________________________________________________
 Michael Zucca - mrz5149@acm.org - http://www.mdc.net/~mrz5149/
 "I will choose a path that's clear. I will choose Freewill. "
  --Rush, Freewill
_______________________________________________________________________



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
