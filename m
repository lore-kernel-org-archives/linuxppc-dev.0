From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15161.54515.559935.629883@cargo.ozlabs.ibm.com>
Date: Wed, 27 Jun 2001 22:43:31 +1000 (EST)
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-commit@ppcbk.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: rearrangements in linuxppc_2_4_devel
In-Reply-To: <3B39C8AA.5000605@humboldt.co.uk>
References: <15161.33091.788459.48900@cargo.ozlabs.ibm.com>
	<3B39C8AA.5000605@humboldt.co.uk>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Adrian Cox writes:

> APUS is probably broken, because it believes that it can call
> parse_bootinfo with a pointer to the boot records. From apus_setup.c:

APUS uses the m68k bootinfo format anyway, which ours is gratuitously
different from.  The apus booter probably does pass the address in a
register, which would actually be the sensible thing to do. :)

> Paul: would you take patches that moved some of this stuff into header
> files, and if so, which header file would you like all the miscellaneous
> setup functions to move into?

Ummm, it would depend which functions you're talking about.  There is
certainly an argument for having a couple more .h files in
arch/ppc/kernel to declare functions that are used only in
arch/ppc/kernel/*.c.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
