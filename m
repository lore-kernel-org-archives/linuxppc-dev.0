Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4A386B6EF3
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2012 04:05:00 +1100 (EST)
Date: Tue, 20 Mar 2012 18:04:50 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull 'next' branch of 5xxx tree
Message-ID: <20120320180450.5f6dffe4@wker>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

please pull some mpc5xxx patches for linux-next. Thanks!

Anatolij

The following changes since commit 01e8ec4417d3c484986af0adaa0ae6632e0a59cd:

  powerpc: Fix power4/970 idle code regression with lockdep (2012-03-16 09:28:17 +1100)

are available in the git repository at:
  git://git.denx.de/linux-2.6-agust.git next

Andrea Gelmini (1):
      Documentation/powerpc/mpc52xx.txt: Checkpatch cleanup

Grant Likely (1):
      powerpc/5200: convert mpc5200 to use of_platform_populate()

Heiko Schocher (4):
      powerpc/mpc5200: update mpc5200_defconfig to fit for charon board
      powerpc/mpc52xx: setup port_config and CDM settings through DT
      powerpc/mpc52xx: add a4m072 board support
      powerpc/mpc5200: add options to mpc5200_defconfig

 .../devicetree/bindings/powerpc/fsl/mpc5200.txt    |   17 ++
 Documentation/powerpc/mpc52xx.txt                  |   12 +-
 arch/powerpc/boot/dts/a4m072.dts                   |  168 ++++++++++++++++++++
 arch/powerpc/configs/mpc5200_defconfig             |   27 ++--
 arch/powerpc/platforms/52xx/mpc5200_simple.c       |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c       |   37 ++++-
 6 files changed, 236 insertions(+), 26 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/a4m072.dts
