Date: Tue, 7 Mar 2000 14:53:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: nvram access in 2.3.48?
Message-ID: <20000307145321.F399@opus.bloom.county>
References: <200003072129.WAA00353@piglet.grunz.lu> <20000307144823.E399@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000307144823.E399@opus.bloom.county>; from trini@kernel.crashing.org on Tue, Mar 07, 2000 at 02:48:23PM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Mar 07, 2000 at 02:48:23PM -0700, Tom Rini wrote:

> On Tue, Mar 07, 2000 at 10:29:45PM +0100, Michel Lanners wrote:
>
> > Another weiredity I've come across in my 2.3 crusade: /dev/nvram
> > doesn't seem to work anymore.
>
> Near as I can tell (and I'm about to try this and then see if bk will pass
> it along happily) is that all the calls to nvram_init have been changed to
> pmac_nvram_init.

On further inspection, it's not.   Eugg.  It looks like the functionality of
drivers/macintosh/nvram.c needs to be added to arch/ppc/kernel/pmac_nvram.c
(Some other drivers depend on the drivers version functionality, which is
working I _think_..

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
