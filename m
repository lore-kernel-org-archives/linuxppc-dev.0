Message-Id: <200106290629.IAA01327@piglet.grunz.lu>
Date: Fri, 29 Jun 2001 08:29:51 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Cleanups of arch/ppc/boot/Makefile
To: trini@kernel.crashing.org
Cc: linuxppc-commit@ppcbk.mvista.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20010628140434.C18845@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  28 Jun, this message from Tom Rini echoed through cyberspace:
> Hey all.  After talking to paulus a bit, arch/ppc/boot/Makefile needs some
> cleaning and fixing.
[snip]

+subdir-$(CONFIG_PRPMC750)	+= pp3 lib images common
+tools-$(CONFIG_PRPMC750)	:= mkbugboot mkprep
+subdir-$(CONFIG_MCPN765)	+= pp3 lib images common
+tools-$(CONFIG_MCPN750)		:= mkbugboot mkprep
                    ^^^
Is this right? Shouldn't that be CONFIG_MCPN765?

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
