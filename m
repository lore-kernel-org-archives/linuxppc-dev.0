Date: Thu, 27 Mar 2003 11:48:53 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: luca gambazzi <luca.gambazzi@epfl.ch>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on PowerCore CPCI-3750
Message-ID: <20030327184853.GE31771@ip68-0-152-218.tc.ph.cox.net>
References: <1048770148.32275.11.camel@shampoo.epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1048770148.32275.11.camel@shampoo.epfl.ch>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Mar 27, 2003 at 02:02:28PM +0100, luca gambazzi wrote:

> i'm swiss student, i'm trying to crosscompile a linux kernel for a Force
> Computers PowerCore CPCI-3750.
[snip]
> so my kernel image is wrong,... to create the kernel image (v2.5 patched
> for ppc) i've used the make bzImage and then with powerpc-linux-objcopy
> i've changed the ELF32bit file in a binary data file.
> what's worng? can somebody tell me where fine documentation?

You should probably be using the 'linuxppc_2_4_devel' tree, see
http://penguinppc.org/dev/kernel.shtml.  Second, 'bzImage' is an alias
for 'zImage' on PPC.  Finally, 'arch/ppc/boot/images/zImage.pcore'
should work as-is.  This is true for 2.5 as well, so you can test with
your current kernel tree and just boot that file as is

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
