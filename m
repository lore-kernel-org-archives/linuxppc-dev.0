Message-ID: <3B862F69.38E9F20C@raleigh.ibm.com>
Date: Fri, 24 Aug 2001 06:41:45 -0400
From: Ralph Blach <rcblach@raleigh.ibm.com>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: "Marti, Felix" <fmarti@desanasystems.com>,
	"'Troy Benjegerdes'" <hozer@drgw.net>,
	Linix PPC Emmbedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: using the little endian bit 4xx mmu
References: <1DF71FB881F4D311A6B700C04FA06A1AC437B4@orca.desanasystems.com> <3B85D758.572A0AD8@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan,

Because its there, and its been hacked in here and the people here have
found it VERY useful and convienent.  4xx specific or not, the people
found it extremely convienent.


Chip

Dan Malek wrote:
>
> "Marti, Felix" wrote:
> >
> > I hacked it in a few hours:
> > in arch/ppc/kernel/head_4xx.S
>
> Ugh....we have discussed this in the past.  What is the advantage
> of using this feature?  All of the existing drivers and I/O macros
> are designed to handle mixing of endian modes depending upon the
> processor and I/O device.  All this does is complicate a standard
> set of programming interfaces that everyone expects to work as they
> have in the past.
>
> The ability to set a feature flag in the PTE and transfer that to
> the TLB isn't a solution to anything.  You are going to have to
> rewrite all of the standard functions, macros, and device drivers
> to utilize this feature, and we haven't seen any benefit to doing this.
>
>         -- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
