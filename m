Date: Wed, 28 Nov 01 09:14:42 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111281714.AA27362@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Platform files question
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Armin Kuster <akuster@mvista.com> wrote:

> AFAIK your board header should go in include/asm-ppc/platforms and your
> board.c file should go arch/ppc/platforms

Then are all the platforms that have their headers together with source files
in arch/ppc/platforms and nothing in include/asm-ppc wrong? For example, back
in MVista's 2.2 tree k2.h was in include/asm-ppc, but when I got to the public
tree, which by then was linuxppc_2_4_devel, it moved to arch/ppc/kernel and is
now in arch/ppc/platforms.

MS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
