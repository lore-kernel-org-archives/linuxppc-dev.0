Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B010C2C00BB
 for <linuxppc-dev@ozlabs.org>; Mon, 29 Apr 2013 19:43:11 +1000 (EST)
Date: Mon, 29 Apr 2013 11:42:50 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Please pull 'next' branch of 5xxx tree
Message-ID: <20130429114250.1f4285c9@crub>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben !

Please pull mpc5xxx patches for v3.10. There are some changes
for mpc5121 generic platform code to support mpc5125 SoC and DTS
files for ac14xx and MPC5125-TWR boards.

All these patches have already been in linux-next for a while.

Thanks,

Anatolij

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.denx.de/linux-2.6-agust.git next

for you to fetch changes up to fdeaf0e20e9f3999c5cb129e821595fe927bf259:

  powerpc/512x: add ifm ac14xx board (2013-04-10 20:48:44 +0200)

----------------------------------------------------------------
Anatolij Gustschin (2):
      powerpc/mpc512x: create SoC devices for more nodes
      powerpc/512x: add ifm ac14xx board

Matteo Facchinetti (2):
      powerpc/512x: move mpc5121_generic platform to mpc512x_generic.
      powerpc/mpc512x: add platform code for MPC5125.

 arch/powerpc/boot/dts/ac14xx.dts                   |  392 ++++++++++++++++++++
 arch/powerpc/boot/dts/mpc5121.dtsi                 |    2 +-
 arch/powerpc/boot/dts/mpc5121ads.dts               |    2 +-
 arch/powerpc/boot/dts/mpc5125twr.dts               |  233 ++++++++++++
 arch/powerpc/boot/dts/pdm360ng.dts                 |    2 +-
 arch/powerpc/configs/mpc512x_defconfig             |    2 +-
 arch/powerpc/platforms/512x/Kconfig                |    8 +-
 arch/powerpc/platforms/512x/Makefile               |    2 +-
 arch/powerpc/platforms/512x/clock.c                |    9 +-
 arch/powerpc/platforms/512x/mpc512x.h              |    1 +
 .../512x/{mpc5121_generic.c => mpc512x_generic.c}  |   12 +-
 arch/powerpc/platforms/512x/mpc512x_shared.c       |   33 +-
 12 files changed, 674 insertions(+), 24 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/ac14xx.dts
 create mode 100644 arch/powerpc/boot/dts/mpc5125twr.dts
 rename arch/powerpc/platforms/512x/{mpc5121_generic.c => mpc512x_generic.c} (83%)
