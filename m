Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.31])
	by ozlabs.org (Postfix) with ESMTP id 3B1FBDDE21
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 22:03:37 +1000 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so1508940ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 06 Aug 2008 05:03:35 -0700 (PDT)
Subject: Please pull 'for-2.6.27' branch of 4xx tree
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Content-Type: text/plain
Date: Wed, 06 Aug 2008 08:03:26 -0400
Message-Id: <1218024206.2328.58.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please grab the tree below.  It contains some fixes for the PIKA Warp
board, and some much needed defconfig updates for .27.

josh

The following changes since commit 2e1e9212ed8c532c6b324de77d3cafef5d2bc846:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../lethal/sh-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.27

Josh Boyer (1):
      powerpc/4xx: Update defconfig files for 2.6.27-rc1

Sean MacLennan (3):
      powerpc/4xx: Cleanup Warp for i2c driver changes.
      powerpc/44x: Warp DTS changes for board updates
      powerpc/44x: Incorrect NOR offset in Warp DTS

Valentine Barshak (1):
      powerpc/44x: Adjust warp-nand resource end address

 arch/powerpc/boot/dts/warp.dts                 |   22 ++-
 arch/powerpc/configs/40x/ep405_defconfig       |  207 +++++++++----
 arch/powerpc/configs/40x/kilauea_defconfig     |  196 +++++++++----
 arch/powerpc/configs/40x/makalu_defconfig      |  196 +++++++++----
 arch/powerpc/configs/40x/walnut_defconfig      |  203 +++++++++----
 arch/powerpc/configs/44x/bamboo_defconfig      |  206 +++++++++----
 arch/powerpc/configs/44x/canyonlands_defconfig |  116 +++++---
 arch/powerpc/configs/44x/ebony_defconfig       |  207 +++++++++----
 arch/powerpc/configs/44x/katmai_defconfig      |  259 ++++++++++++-----
 arch/powerpc/configs/44x/rainier_defconfig     |  207 +++++++++----
 arch/powerpc/configs/44x/sam440ep_defconfig    |  109 ++++++--
 arch/powerpc/configs/44x/sequoia_defconfig     |  207 +++++++++----
 arch/powerpc/configs/44x/taishan_defconfig     |  208 +++++++++----
 arch/powerpc/configs/44x/virtex5_defconfig     |  100 +++++--
 arch/powerpc/configs/44x/warp_defconfig        |  232 +++++++++++-----
 arch/powerpc/configs/ppc40x_defconfig          |  374 +++++++++++++++++++-----
 arch/powerpc/configs/ppc44x_defconfig          |  375 ++++++++++++++++++++++--
 arch/powerpc/platforms/44x/warp-nand.c         |    2 +-
 arch/powerpc/platforms/44x/warp.c              |   25 +-
 19 files changed, 2540 insertions(+), 911 deletions(-)
