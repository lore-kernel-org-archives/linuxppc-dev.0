From: Juergen Beisert <jbeisert@eurodsn.de>
Reply-To: jbeisert@eurodsn.de
To: v.sudeep@exgate.tek.com
Subject: Re: dummy_con
Date: Mon, 15 Dec 2003 16:33:05 +0100
References: <301A812E6528D511A8F70008C71E57860290F8B0@ap-bang-m02.india.tek.com>
In-Reply-To: <301A812E6528D511A8F70008C71E57860290F8B0@ap-bang-m02.india.tek.com>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200312151633.05167.jbeisert@eurodsn.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

> THE PROBLEM:  While compiling the kernel I get the following error.
> arch/ppc/kernel/kernel.o: In function `ppc4xx_setup_arch':
> arch/ppc/kernel/kernel.o(.text.init+0xbee): undefined reference to
> `dummy_con'
> arch/ppc/kernel/kernel.o(.text.init+0xbf2): undefined reference to
> `dummy_con'
> arch/ppc/kernel/kernel.o(.text.init+0xbf6): undefined reference to
> `conswitchp'
> arch/ppc/kernel/kernel.o(.text.init+0xbfa): undefined reference to
> `conswitchp'
> drivers/char/char.o: In function `chr_dev_init':
> drivers/char/char.o(.text.init+0x248): undefined reference to `fbmem_init'
> drivers/char/char.o(.text.init+0x248): relocation truncated to fit:
> R_PPC_REL24 fbmem_init
> make: *** [vmlinux] Error 1

Try activate the "Virtual terminal" and "Support for console on virtual
terminal".

JB


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
