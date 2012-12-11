Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1DF522C0090
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Dec 2012 19:23:54 +1100 (EST)
Date: Tue, 11 Dec 2012 09:23:47 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull 'next' branch of 5xxx tree
Message-ID: <20121211092347.543f29ca@wker>
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

Hi Ben,

please pull mpc5xxx patches for v3.8. There is a dts for a
new a3m071 board, a fix for optional mpc5121 DIU support and
minor changes to mpc5200 lpbfifo driver to simplify module
init/exit code. These patches have already been in linux-next
for a while. Thanks!

Anatolij

The following changes since commit b69f0859dc8e633c5d8c06845811588fe17e68b3:

  Linux 3.7-rc8 (2012-12-03 11:22:37 -0800)

are available in the git repository at:
  git://git.denx.de/linux-2.6-agust.git next

Srinivas Kandagatla (1):
      powerpc/mpc52xx: use module_platform_driver macro

Stefan Roese (1):
      powerpc: mpc5200: Add a3m071 board support

Timur Tabi (1):
      powerpc/512x: don't compile any platform DIU code if the DIU is not enabled

 arch/powerpc/boot/dts/a3m071.dts              |  144 +++++++++++++++++++++++++
 arch/powerpc/platforms/512x/Kconfig           |    1 -
 arch/powerpc/platforms/512x/mpc5121_ads.c     |    3 +
 arch/powerpc/platforms/512x/mpc512x.h         |   11 ++-
 arch/powerpc/platforms/512x/mpc512x_shared.c  |   25 +----
 arch/powerpc/platforms/52xx/mpc5200_simple.c  |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   16 +---
 7 files changed, 162 insertions(+), 39 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/a3m071.dts
