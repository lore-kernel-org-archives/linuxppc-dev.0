Message-ID: <3AC36575.ED5A0935@matrox.com>
Date: Thu, 29 Mar 2001 11:40:21 -0500
From: =?iso-8859-1?Q?S=E9bastien=20C=F4t=E9?= <scote1@matrox.com>
MIME-Version: 1.0
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Stability of MontaVista's 2.4.0-test2-1.2.2-1
References: <H00002af04b2e173@MHS> <3AC23B01.A9162C3B@matrox.com> <3AC25348.C33F8692@mvista.com> <20010329163258.C13092@mangodsp.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alex Shnitman wrote:
> I've just tried it. I downloaded the tree with bitkeeper, and applied
> sp_patch_25, but got the following linking errors at the final stage
> of the compilation:

I just downloaded 2_5 with Bitkeeper and I got the same problem.

Isn't there any daily snapshots located somewhere??  I can't download
using Bitkeeper from here because of the proxy.

Sébas..

P.S.: Here's the errors I get:
arch/ppc/kernel/kernel.o: In function `sandpoint_get_irq':
arch/ppc/kernel/kernel.o(.text+0x99b8): undefined reference to
`openpic_irq'
arch/ppc/kernel/kernel.o(.text+0x99b8): relocation truncated to fit:
R_PPC_REL24 openpic_irq
arch/ppc/kernel/kernel.o(.text+0x99dc): undefined reference to
`openpic_eoi'
arch/ppc/kernel/kernel.o(.text+0x99dc): relocation truncated to fit:
R_PPC_REL24 openpic_eoi
arch/ppc/kernel/kernel.o: In function `sandpoint_post_irq':
arch/ppc/kernel/kernel.o(.text+0x9a2c): undefined reference to
`openpic_eoi'
arch/ppc/kernel/kernel.o(.text+0x9a2c): relocation truncated to fit:
R_PPC_REL24 openpic_eoi
make: *** [vmlinux] Error 1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
