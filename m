Message-ID: <3B8C7D0E.D88A0689@mvista.com>
Date: Wed, 29 Aug 2001 01:26:38 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-commit@source.mvista.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Remove some stuff from arch/ppc/boot/Makefile... (2_4_devel)
References: <20010828184504.E15262@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:
>
> Okay.  Since I've already posted a patch vs 2_4_devel to kill the 'mbx' dir,

I just pushed an update that pulls "treeboot" into the 'mbx' directory.
I had a conflict with your latest update, I had to manually resolve it
so I hope I chose the right '<<<<<<' code :-).

Anyway, you can take that directory and merge it.  I'll look at the
results when I get back from racing on Monday.

I created a 'mktree' program along the lines of mkprep, mkchrp, etc.
We can get rid of that 1000 lines of Perl or whatever that crap was
that I couldn't understand.  The 'mktree' program only works properly
on big endian hosts (but who would use anything else? :-).  I looked
at some of the 'cross' modifications done by Porter to the other
programs,
and I guess I'll get around to that when I return.

We should also be able to include the Spruce build in this as well,
since it is a treeboot image.

Thanks.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
