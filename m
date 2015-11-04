Return-Path: <agust@denx.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C6EFA1A0C0C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 08:09:44 +1100 (AEDT)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 464CB1402D2
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Nov 2015 08:09:43 +1100 (AEDT)
Date: Wed, 4 Nov 2015 21:58:26 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Pull request: powerpc/mpc5xxx next
Message-ID: <20151104215826.3d0e094d@crub>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Highlights include a driver for MPC512x LocalPlus Bus FIFO with its
device tree binding documentation, mpc512x device tree updates and
some minor fixes.

These patches have already been queued for linux-next for a while.

The following changes since commit 353169acf1858bb2dc3f91475dafabce547de14c:

  powerpc/eeh: Fix recursive fenced PHB on Broadcom shiner adapter (2015-10=
-21 20:42:16 +1100)

are available in the git repository at:

  git://git.denx.de/linux-denx-agust.git next

for you to fetch changes up to 39e69f55f85731d9c0320c03212a4d1f149464f0:

  powerpc: Introduce the use of the managed version of kzalloc (2015-10-22 =
16:13:23 +0200)

----------------------------------------------------------------
Alexander Popov (2):
      powerpc/512x: add LocalPlus Bus FIFO device driver
      powerpc/512x: add a device tree binding for LocalPlus Bus FIFO

Himangi Saraogi (1):
      powerpc: Introduce the use of the managed version of kzalloc

Luis de Bethencourt (1):
      powerpc: platforms: mpc52xx_lpbfifo: Fix module autoload for OF platf=
orm driver

Uwe Kleine-K=C3=B6nig (1):
      powerpc: mpc512x: drop bogus and unused psc register bit definitions

 .../bindings/powerpc/fsl/mpc512x_lpbfifo.txt       |   21 +
 arch/powerpc/boot/dts/mpc5121.dtsi                 |   11 +-
 arch/powerpc/boot/dts/mpc5125twr.dts               |   11 +-
 arch/powerpc/configs/mpc512x_defconfig             |    1 +
 arch/powerpc/include/asm/mpc5121.h                 |   59 +++
 arch/powerpc/include/asm/mpc52xx_psc.h             |    2 -
 arch/powerpc/platforms/512x/Kconfig                |    6 +
 arch/powerpc/platforms/512x/Makefile               |    1 +
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c      |  540 ++++++++++++++++=
++++
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c          |    6 +-
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c      |    1 +
 11 files changed, 650 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpc512x_l=
pbfifo.txt
 create mode 100644 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c
