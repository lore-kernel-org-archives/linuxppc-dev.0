Date: Sat, 31 Jul 2004 14:53:03 +0200
From: Giuliano Pochini <pochini@shiny.it>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14 c
Message-Id: <20040731145303.26170308.pochini@shiny.it>
In-Reply-To: <20040730210318.GS16468@smtp.west.cox.net>
References: <20040728220733.GA16468@smtp.west.cox.net>
	<XFMail.20040729100549.pochini@shiny.it>
	<20040729144347.GE16468@smtp.west.cox.net>
	<20040730205901.4d4181f4.pochini@shiny.it>
	<20040730190731.GQ16468@smtp.west.cox.net>
	<20040730224828.0f06e37a.pochini@shiny.it>
	<20040730210318.GS16468@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 30 Jul 2004 14:03:18 -0700
Tom Rini <trini@kernel.crashing.org> wrote:

>
> On Fri, Jul 30, 2004 at 10:48:28PM +0200, Giuliano Pochini wrote:
>
> [snip]
> > gcc 3.3.3 + binutils 2.15 fails quite soon here:
> >
> >   AS      arch/ppc/kernel/l2cr.o
> > arch/ppc/kernel/l2cr.S: Assembler messages:
> > arch/ppc/kernel/l2cr.S:110: Error: Unrecognized opcode: `dssall'
> > arch/ppc/kernel/l2cr.S:278: Error: Unrecognized opcode: `dssall'
> > arch/ppc/kernel/l2cr.S:387: Error: Unrecognized opcode: `dssall'
> > make[1]: *** [arch/ppc/kernel/l2cr.o] Error 1
>
> Can you try with the following ?
> [...]

It doesn't apply to plain 2.6.7. What version I have to use ?


--
Giuliano.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
