From: Joe Green <jgreen@mvista.com>
To: "M. Tim Jones" <mtj@mtjones.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Doc/Serial problems in HHL 1.2?
Date: Thu, 17 Aug 2000 08:30:18 -0700
Content-Type: text/plain
References: <399B9874.99CF5C1C@mtjones.com>
In-Reply-To: <399B9874.99CF5C1C@mtjones.com>
MIME-Version: 1.0
Message-Id: <00081708394601.01481@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 17 Aug 2000, M. Tim Jones wrote:
> I've just installed the HHL 1.2 CD and I've run into a couple of
> problems.
>
> After installing the 1.2 CD, the 'make' would not work without studying
> the Makefile and then adding a couple of files (.hhl_target_cpu and
> .hhl_cross_compile).  After putting these in, the compile began but then
> ffailed at math-emu (it no longer exists in the 1.2 subdirectory tree).
> Are the .hhl* files created automatically somewhere?  Upon removing the
> Math Emulation configuration item, the build continued.
>
> Finally, the kernel built for the 860CLLF consistently results in a Bad
> Trap in my_console_write.  It appears that the uart.c file (where
> my_console_write resides) has undergone major surgery.
>
> Any idea what's up?

I'm guessing that you are trying to use the hhl-kernel* package.  This
is the generic kernel source; it's really only used to build the
target-specific packages.

You really should be using one of the LSP (Linux Support Package) RPMs.
These include the .hhl files (which configure the kernel build
architecture and cross development tools) and an appropriate default
configuration.  I don't think we have an 860CLLF LSP, but the mbx860 or
linuxplanet configs should be close.

Everything is include in the LSP; you don't even have to have the
hhl-kernel RPM installed to build a kernel for an LSP.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
