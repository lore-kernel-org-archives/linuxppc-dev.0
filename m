From: Brad Boyer <flar@marcus.pants.nu>
Message-Id: <199909111051.DAA22465@marcus.pants.nu>
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
To: ldl@chpc.utah.edu (Lou Langholtz)
Date: Sat, 11 Sep 1999 03:51:25 -0700 (PDT)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <37D929E4.205A04B8@chpc.utah.edu> from "Lou Langholtz" at Sep 10, 99 09:55:16 am
Content-Type: text
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Lou Langholtz wrote:
> I've posted before about this problem but to a different audience. As
> I'm hoping to get this resolved (fixed) though in the main source tree
> but don't have the chance to test this entirely myself I'm resending
> here hoping someone else can test things out...
> 
> After getting an extra 2MB VRAM for my PowerMac7500 and seeing that only
> 2MB were still being recognized (despite having just added the 2MB to
> total to 4MB VRAM), I dug into the controlfb.c code from 2.2.11 and
> 2.2.12 and made the following changes to get all 4MB VRAM recognized:

Just remember when making changes like this that the old code works fine
for some people.  I've had 4M in my 7600 for a long time, and never once
had a problem with Linux saying I only had 2M.  I don't often have the
time to do kernel hacking, but I'll try to get a kernel with this patch
up and running on my computer to see if it breaks things.  I suspect it
will, since it seems that the old way of detecting is removed.

Hopefully I can get back to you on this in a few days.

	Brad Boyer
	flar@pants.nu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
