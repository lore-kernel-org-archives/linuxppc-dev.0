Message-ID: <3A82F363.DCA9EC2F@mvista.com>
Date: Thu, 08 Feb 2001 14:28:35 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Magnus Damm <damm@opensource.se>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: bk-linuxppc_2_4 mpc8xx compile fix
References: <3A82EECF.EF4D5A8@opensource.se>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Magnus Damm wrote:

> arch/ppc/kernel/kernel.o: In function `SoftwareEmulation':
> arch/ppc/kernel/kernel.o(.text+0xa04): undefined reference to
> `Soft_emulate_8xx'
> arch/ppc/kernel/kernel.o(.text+0xa04): relocation truncated to fit:
> R_PPC_REL24 Soft_emulate_8xx
> make: *** [vmlinux] Error 1
>
> The relevant .config line:
>
> # CONFIG_MATH_EMULATION is not set

The intention here is to remove the old, original, half-assed emulate
a few instructions function.  Either you get floating point emulation
or you don't.  I wrote the original version long ago before there was
floating point emulation, just to make a little forward progress.  It's
time to remove it and I guess the Makefiles, configuration, and real
code files didn't get updated together.

Use whatever works (you won the prize :-), and it will be fixed up
shortly.

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
