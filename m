Date: Tue, 21 Aug 2001 08:19:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dag Nygren <dag@newtech.fi>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC embedded plans ?
Message-ID: <20010821081929.A6366@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010821065240.1853.qmail@dag.newtech.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010821065240.1853.qmail@dag.newtech.fi>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 21, 2001 at 09:52:40AM +0300, Dag Nygren wrote:

> Checking out the sources I think I  can notice that there is a strong
> push towards some kind of "one file" machine definition.

Sort of.  To do a new board port in 2.4.9 (in linuxppc_2_4_devel), you
only need to edit arch/ppc/kernel/Makefile, arch/ppc/boot/Makefile and
possibly include/asm-ppc/serial.h.  And arch/ppc/config.in too, of course.
No more new _MACH_xxx's, there's now ppc_md.setup_io_mappings (or so),
to do what used to be done in MMU_init and case'ing of the _MACH.

> And what would be the best 2.4.9 to start out with ?

2_4_devel, http://penguinppc.org/dev/kernel.shtml

> Any written policy on the setup of the machine dependant stuff ?

Nope.  Follow the examples.

> Any way of getting my board defs into the official (?) PPC source tree ?

If you submit them.  Here, linuxppc-dev and linuxppc-commit@source.mvista.com
are all good places to try.  The -dev list more so.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
