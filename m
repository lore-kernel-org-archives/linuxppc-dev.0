Date: Tue, 7 Mar 2000 15:15:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: nvram access in 2.3.48?
Message-ID: <20000307151532.G399@opus.bloom.county>
References: <20000307144823.E399@opus.bloom.county> <200003072152.WAA00417@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200003072152.WAA00417@piglet.grunz.lu>; from mlan@cpu.lu on Tue, Mar 07, 2000 at 10:52:09PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 07, 2000 at 10:52:09PM +0100, Michel Lanners wrote:

> That was in a drivers/char file, under drivers/macintosh, and under
> arch/ppc, if I rember right....

Right.  drivers/char/nvram.c is the PC-style NVRAM driver.  CHRP and PReP(?)
can use it.  drivers/macintosh/nvram.c is the PMac-style (Basically pre-new
world rom).  arch/ppc/kernel/pmac_nvram is for anything newer then that, it
seems.  Somehow, all three need to co-exist happily.  What _should_ be the
"easy" way is to merge the drivers/macintosh and arch/ppc/kernel ones together.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
