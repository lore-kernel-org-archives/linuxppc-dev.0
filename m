Message-ID: <3BAB189F.5B5B19CD@raleigh.ibm.com>
Date: Fri, 21 Sep 2001 06:38:23 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Holger Bettag <hobold@Informatik.Uni-Bremen.DE>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc LE questions (seeking help hand info pointers)
References: <20010920171002.37DCA2B54A@marcus.pants.nu>
		<3BAA363B.5010400@mc.com> <8xlmj9psnw.fsf@s62.informatik.uni-bremen.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


One the 405 processors, with the endian bit set, the data is will be
true little endian.

Chip

Holger Bettag wrote:
>
> Mark Salisbury <mbs@mc.com> writes:
>
> [... linux in ppc little endian mode ...]
> > well, this is in the context of a multi-CPU type (x86/ppc, sparc/ppc,
> > ppc/ppc, mips/ppc) shared memory multicomputer.
> >
> > when dealing w/ direct mapped, shared memory, uniformity of endian-ness
> > makes many multicomputer problems easier to solve.(not to mention easier
> > for the customer to program...)
> >
> You are aware that a PPC in little endian mode is merely tricking with the
> low order address bits, but does not actually lay out its data in a little
> endian fashion in physical memory?
>
>   Holger
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
