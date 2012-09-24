Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AA9552C008E
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2012 00:45:25 +1000 (EST)
Date: Mon, 24 Sep 2012 16:45:01 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull 'next' branch of 5xxx tree
Message-ID: <20120924164501.5c738c70@wker>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

please pull mpc5xxx patches for next. Thanks!

Anatolij

The following changes since commit 55d512e245bc7699a8800e23df1a24195dd08217:

  Linux 3.6-rc5 (2012-09-08 16:43:45 -0700)

are available in the git repository at:
  git://git.denx.de/linux-2.6-agust.git next

Anatolij Gustschin (3):
      powerpc/mpc5200: add dts files for ifm camera machines
      dt/misc: add bindings documentation for ifm camera sensor interface
      powerpc/mpc52xx_lpbfifo: optionally defer fifo transfer start

Paul Gortmaker (1):
      powerpc: Option FB_FSL_DIU is not really optional for mpc512x

Richard Weinberger (1):
      powerpc: 512x: Fix mpc5121_clk_get()

 Documentation/devicetree/bindings/misc/ifm-csi.txt |   41 ++++++
 arch/powerpc/boot/dts/o2d.dts                      |   47 +++++++
 arch/powerpc/boot/dts/o2d.dtsi                     |  139 ++++++++++++++++++++
 arch/powerpc/boot/dts/o2d300.dts                   |   52 ++++++++
 arch/powerpc/boot/dts/o2dnt2.dts                   |   48 +++++++
 arch/powerpc/boot/dts/o2i.dts                      |   33 +++++
 arch/powerpc/boot/dts/o2mnt.dts                    |   33 +++++
 arch/powerpc/boot/dts/o3dnt.dts                    |   48 +++++++
 arch/powerpc/include/asm/mpc52xx.h                 |    2 +
 arch/powerpc/platforms/512x/Kconfig                |    1 +
 arch/powerpc/platforms/512x/clock.c                |    6 +-
 arch/powerpc/platforms/512x/mpc512x_shared.c       |    6 -
 arch/powerpc/platforms/52xx/mpc5200_simple.c       |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c      |   35 +++++-
 14 files changed, 483 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/misc/ifm-csi.txt
 create mode 100644 arch/powerpc/boot/dts/o2d.dts
 create mode 100644 arch/powerpc/boot/dts/o2d.dtsi
 create mode 100644 arch/powerpc/boot/dts/o2d300.dts
 create mode 100644 arch/powerpc/boot/dts/o2dnt2.dts
 create mode 100644 arch/powerpc/boot/dts/o2i.dts
 create mode 100644 arch/powerpc/boot/dts/o2mnt.dts
 create mode 100644 arch/powerpc/boot/dts/o3dnt.dts
