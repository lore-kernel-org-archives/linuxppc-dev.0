Date: Tue, 11 Nov 2003 08:36:58 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christian <evil@g-house.de>
Cc: linas@austin.ibm.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: ppc32 lockups with 2.6
Message-ID: <20031111153658.GH8584@ip68-0-152-218.tc.ph.cox.net>
References: <3FA5698A.9000905@g-house.de> <3FAABE62.4090804@g-house.de> <20031110125044.A22030@forte.austin.ibm.com> <3FB01392.60500@g-house.de> <20031110175740.A32176@forte.austin.ibm.com> <3FB02C85.6090400@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3FB02C85.6090400@g-house.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 11, 2003 at 01:25:41AM +0100, Christian wrote:
>
> linas@austin.ibm.com wrote:
> >
> >kdb is a built-in kernel debugger. gdb is useless for this case,
> >although kgdb could be another alternative.
>
> yes, i thought so. i'm still a bit confused if "kdb" and "kgdb".
>
> as http://kgdb.sourceforge.net/whichdebugger.html points out, kdb would
> be the better choice here, but i don't see any "kdb" within the kernel
> config nor does it seem to be a user space-tool. anyway, i have
>
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_SLAB=y
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_KGDB=y
> CONFIG_KGDB_TTYS1=y
> CONFIG_XMON=y
> CONFIG_DEBUG_INFO=y
> CONFIG_BOOTX_TEXT=y

Note that with XMON and KGDB both enabled, you'll get xmon instead,
which again I _think_ works on PReP (but it was long ago when I tested)
and here I think you'll be better off with KGDB.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
