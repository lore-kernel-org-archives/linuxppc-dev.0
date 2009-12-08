Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 87F3DB6F0C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Dec 2009 08:34:19 +1100 (EST)
Received: by yxe8 with SMTP id 8so5878447yxe.17
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Dec 2009 13:34:18 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <fa686aa40911042210q5bbbca2fi82911b7245d17588@mail.gmail.com>
References: <fa686aa40911042210q5bbbca2fi82911b7245d17588@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 8 Dec 2009 14:33:58 -0700
Message-ID: <fa686aa40912081333r53cdc5d4ldc45dcfdd2e7536f@mail.gmail.com>
Subject: Re: 2.6.33 -next tree
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	David Brownell <dbrownell@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 4, 2009 at 11:10 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> Hi Ben, Stephen.
>
> I just prepared my next branch for 2.6.33:
> git://git.secretlab.ca/git/linux-2.6 next
>
> Steven, can you please add this tree to your linux-next pull list?
> This is the branch where I put stuff that gets fed up to Ben. =A0This is
> separate from the branch that I'm using to collect OF related changes
> and that you are already pulling in.
>
> Ben, can you please pull this branch into your -next tree for 2.6.33?

Ben: ping?

Are you able to pull this tree, or should I ask Linus to pull it directly?

It contains mpc5200 and xilinx stuff.  Some of it is SPI related, but
I'm now the SPI co-maintainer, so I have no problem with it going in
via your tree.  :-)  Regardless, I want to get it out to Linus ASAP.

This tree has also been in linux-next for a while now, so it should be
a safe pull.

Thanks,
g.

> Andrew & David, you'll notice that I've also got some SPI and MMC
> changes in this branch (PPC and OF related stuff) since there is no
> current MMC maintainer, and some of these SPI patches have been
> hanging around for a while now. =A0Let me know if you object to me
> pushing these changes personally instead of going through another
> maintainer.
>
> Thanks,
> g.
>
> The following changes since commit b419148e567728f6af0c3b01965c1cc141e3e1=
3a:
> =A0Linus Torvalds (1):
> =A0 =A0 =A0 =A0Linux 2.6.32-rc6
>
> are available in the git repository at:
>
> =A0git://git.secretlab.ca/git/linux-2.6 next
>
> Albrecht Dre=DF (1):
> =A0 =A0 =A0powerpc: tiny memcpy_(to|from)io optimisation
>
> Grant Likely (4):
> =A0 =A0 =A0spi/mpc5200: Register SPI devices described in device tree
> =A0 =A0 =A0powerpc/5200: Add mpc5200-spi (non-PSC) device driver
> =A0 =A0 =A0powerpc/5200: add general purpose timer API for the MPC5200
> =A0 =A0 =A0mmc: fix missing module license declaration in of_mmc_spi.c
>
> John Bonesio (1):
> =A0 =A0 =A0powerpc/5200: add LocalPlus bus FIFO device driver
>
> John Linn (1):
> =A0 =A0 =A0Xilinx: SPI: Fix bits_per_word for transfers
>
> Wolfram Sang (2):
> =A0 =A0 =A0spi/mpc52xx-psc-spi: check for valid PSC
> =A0 =A0 =A0spi/mpc52xx: replace printk with dev_err
>
> =A0arch/powerpc/include/asm/mpc52xx.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 46 ++
> =A0arch/powerpc/kernel/io.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A04 +-
> =A0arch/powerpc/platforms/52xx/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +
> =A0arch/powerpc/platforms/52xx/Makefile =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/powerpc/platforms/52xx/mpc52xx_gpt.c =A0 =A0 | =A0133 ++++++-
> =A0arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c | =A0560 +++++++++++++++=
++++++++++
> =A0drivers/mmc/host/of_mmc_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A02 +
> =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 | =A0 =A08 +
> =A0drivers/spi/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| =A0 =A01 +
> =A0drivers/spi/mpc52xx_psc_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 25=
 +-
> =A0drivers/spi/mpc52xx_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0520 +++++++++++++++++++++++
> =A0drivers/spi/xilinx_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A03 +-
> =A0include/linux/spi/mpc52xx_spi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 10 +
> =A013 files changed, 1297 insertions(+), 21 deletions(-)
> =A0create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
> =A0create mode 100644 drivers/spi/mpc52xx_spi.c
> =A0create mode 100644 include/linux/spi/mpc52xx_spi.h
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
