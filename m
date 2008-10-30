Return-Path: <jwboyer@gmail.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id 5AFCFDDDFF
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 09:28:31 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so363941ywh.39
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 15:28:30 -0700 (PDT)
Date: Thu, 30 Oct 2008 18:26:42 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull 'merge' branch of 4xx tree
Message-ID: <20081030222642.GA6690@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull the changes below as updates for 2.6.28.  There is one small
Kconfig fix, and the normal defconfig updates we do every release.

thx,
josh

The following changes since commit 0173a3265b228da319ceb9c1ec6a5682fd1b2d92:
  Linus Torvalds (1):
        Linux 2.6.28-rc2

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git merge

Josh Boyer (3):
      powerpc/40x: Don't enable HCU4 board by default
      powerpc/40x: Update 40x defconfigs
      powerpc/44x: Update 44x defconfigs

 arch/powerpc/configs/40x/acadia_defconfig      |   59 ++++++++----
 arch/powerpc/configs/40x/ep405_defconfig       |   83 +++++++++++-----
 arch/powerpc/configs/40x/hcu4_defconfig        |  125 +++++++++++++++++-------
 arch/powerpc/configs/40x/kilauea_defconfig     |   69 +++++++++----
 arch/powerpc/configs/40x/makalu_defconfig      |   69 +++++++++----
 arch/powerpc/configs/40x/walnut_defconfig      |   77 +++++++++++----
 arch/powerpc/configs/44x/arches_defconfig      |   51 ++++++----
 arch/powerpc/configs/44x/bamboo_defconfig      |   77 +++++++++++----
 arch/powerpc/configs/44x/canyonlands_defconfig |   61 ++++++++----
 arch/powerpc/configs/44x/ebony_defconfig       |   77 +++++++++++----
 arch/powerpc/configs/44x/katmai_defconfig      |   77 +++++++++++----
 arch/powerpc/configs/44x/rainier_defconfig     |   73 ++++++++++----
 arch/powerpc/configs/44x/sam440ep_defconfig    |  110 +++++++++++++++------
 arch/powerpc/configs/44x/sequoia_defconfig     |   78 +++++++++++----
 arch/powerpc/configs/44x/taishan_defconfig     |   77 +++++++++++----
 arch/powerpc/configs/44x/warp_defconfig        |   82 +++++++++++-----
 arch/powerpc/configs/ppc40x_defconfig          |  106 ++++++++++++++++----
 arch/powerpc/configs/ppc44x_defconfig          |  125 ++++++++++++++++++------
 arch/powerpc/platforms/40x/Kconfig             |    2 +-
 19 files changed, 1053 insertions(+), 425 deletions(-)
