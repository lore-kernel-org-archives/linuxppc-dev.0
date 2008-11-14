Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.184])
	by ozlabs.org (Postfix) with ESMTP id 437E4DDDE0
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Nov 2008 06:20:28 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so1377463rnf.16
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Nov 2008 11:20:26 -0800 (PST)
Message-ID: <fa686aa40811141120o2c0394daja732184aefaec901@mail.gmail.com>
Date: Fri, 14 Nov 2008 12:20:25 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Paul Mackerras" <paulus@samba.org>,
	"Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Josh Boyer" <jwboyer@linux.vnet.ibm.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Please pull linux-2.6-mpc52xx.git
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben and Paulus.

Please pull the 'merge' branch of my MPC5200 tree (url below).  I've
got mpc5200 bug fixes, virtex bug fixes and defconfig updates in it.
This all needs to go into 2.6.28.  This branch does have both mpc5200
and Xilinx Virtex 4xx changes.  I've cleared it with Josh that it is
okay to push the 4xx changes out to my tree rather than having him
pull it first.

The following changes since commit 58e20d8d344b0ee083febb18c2b021d2427e56ca:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../jbarnes/pci-2.6

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx merge

Grant Likely (4):
      powerpc/mpc5200: fix bestcomm Kconfig dependencies
      powerpc/virtex: fix various format/casting printk mismatches
      powerpc/52xx: update defconfigs
      powerpc/virtex: Update defconfigs

Yuri Tikhonov (1):
      xsysace: Fix driver to use resource_size_t instead of unsigned long

 arch/powerpc/configs/40x/virtex_defconfig     | 1176 +++++++++++++++++++++++++
 arch/powerpc/configs/44x/virtex5_defconfig    |  234 +++---
 arch/powerpc/configs/52xx/cm5200_defconfig    |  169 +++-
 arch/powerpc/configs/52xx/lite5200b_defconfig |  206 ++++--
 arch/powerpc/configs/52xx/motionpro_defconfig |  168 +++-
 arch/powerpc/configs/52xx/pcm030_defconfig    |  182 +++--
 arch/powerpc/configs/52xx/tqm5200_defconfig   |  180 +++-
 arch/powerpc/configs/mpc5200_defconfig        |  573 +++++++++---
 arch/powerpc/configs/ppc40x_defconfig         |   92 ++-
 arch/powerpc/configs/ppc44x_defconfig         |   92 ++-
 arch/powerpc/sysdev/bestcomm/Kconfig          |    9 +-
 arch/powerpc/sysdev/xilinx_intc.c             |    4 +-
 drivers/block/xsysace.c                       |   23 +-
 drivers/char/xilinx_hwicap/xilinx_hwicap.c    |    9 +-
 drivers/net/Kconfig                           |    3 +-
 drivers/serial/uartlite.c                     |    4 +-
 drivers/video/xilinxfb.c                      |    5 +-
 sound/soc/fsl/Kconfig                         |    3 +-
 18 files changed, 2617 insertions(+), 515 deletions(-)
 create mode 100644 arch/powerpc/configs/40x/virtex_defconfig


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
