Message-ID: <3BFD901A.2750D5CD@linux-m68k.org>
Date: Fri, 23 Nov 2001 00:54:02 +0100
From: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: paulus@samba.org, Armin Kuster <akuster@mvista.com>,
	ppcdevel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New API for non cache coherent ppc cpu's
References: <3BFAB960.DAA72239@mvista.com> <15357.26322.107051.143144@cargo.ozlabs.ibm.com> <3BFD8520.5060105@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Dan Malek wrote:

> For non-PCI devices,
> I call the consistent_* functions, which other architectures support
> and do as well.  So, we kind of have a common interface here for non-PCI
> devices as well.
>
> I stole all of this cache coherency stuff from ARM and Sparc (or MIPS,
> I don't remember) when I did it the first time.

The only other architecture which defines it is ARM?!
The only API which exists at least as dummys everywhere is
dma_cache_(inv|wback).

bye, Roman

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
