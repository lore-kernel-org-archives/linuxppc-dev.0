Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5C41C2C0109
 for <linuxppc-dev@ozlabs.org>; Mon,  4 Nov 2013 11:11:36 +1100 (EST)
Date: Mon, 4 Nov 2013 01:11:23 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull 'next' branch of 5xxx tree
Message-ID: <20131104011123.31e8dfb2@crub>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben !

Please pull mpc5xxx patches for v3.13:

Fixes for build issues when LPB FIFO driver is configured as
a module, removal of #ifdefs in mpc512x DIU platform code and
a revert of recent changes to mpc52xx PIC driver. Wolfram
provided a better fix for PIC driver build issue popping up
when older gcc-4.3.5 is used.

Thanks,
Anatolij
 
The following changes since commit 50bd6153d1a68354a0a0c8bca1fe949fa8875875:

  powerpc/powernv: Code update interface (2013-10-30 16:12:02 +1100)

are available in the git repository at:

  git://git.denx.de/linux-2.6-agust.git next

for you to fetch changes up to 7e198197ec878c720af4dc35c49c0c6a99b83f9f:

  powerpc/mpc512x: remove unnecessary #if (2013-10-30 22:56:10 +0100)

----------------------------------------------------------------
Anatolij Gustschin (1):
      powerpc/52xx: fix build breakage for MPC5200 LPBFIFO module

Brian Norris (1):
      powerpc/mpc512x: remove unnecessary #if

Gerhard Sittig (1):
      powerpc/mpc512x: silence build warning upon disabled DIU

Wolfram Sang (1):
      Kind of revert "powerpc: 52xx: provide a default in mpc52xx_irqhost_map()"

 arch/powerpc/platforms/512x/mpc512x_shared.c |   18 +++++++-----------
 arch/powerpc/platforms/52xx/Kconfig          |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c    |    5 ++---
 arch/powerpc/sysdev/fsl_soc.h                |    3 ---
 4 files changed, 10 insertions(+), 18 deletions(-)
