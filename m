Return-Path: <glikely@secretlab.ca>
Received: from mail-iy0-f170.google.com (mail-iy0-f170.google.com
	[209.85.210.170]) by ozlabs.org (Postfix) with ESMTP id C1FF5B70EC
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2011 10:13:21 +1100 (EST)
Received: by iym14 with SMTP id 14so17541143iym.15
	for <linuxppc-dev@ozlabs.org>; Mon, 03 Jan 2011 15:13:19 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 3 Jan 2011 16:12:59 -0700
Message-ID: <AANLkTinXEDH4=R1XcSfeua-CkZ-gMHA20_Vx9bCxyFA9@mail.gmail.com>
Subject: [git pull] powerpc changes for 2.6.38
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

Here are some of the powerpc patched I've picked up for .38.

g.

The following changes since commit b518a64983cbf2ff31aed530898de2d80e4573d5:

  hwmon: (s3c-hwmon) Fix compilation (2011-01-02 15:31:11 -0800)

are available in the git repository at:
  git://git.secretlab.ca/git/linux-2.6 next

Anatolij Gustschin (1):
      powerpc/5xxx: extend mpc8xxx_gpio driver to support mpc512x gpios

Grant Likely (1):
      Merge v2.6.37-rc8 into powerpc/next

Ilya Yanok (6):
      powerpc/512x: scatter/gather dma fix
      powerpc/512x: fix the hanged dma transfer issue
      powerpc/512x: add MPC8308 dma support
      powerpc/512x: try to free dma descriptors in case of allocation failure
      powerpc/83xx: add DMA controller to mpc8308 device-tree node
      powerpc/83xx: add mpc8308_p1m DMA controller device-tree node

 arch/powerpc/boot/dts/mpc8308_p1m.dts |    8 ++
 arch/powerpc/boot/dts/mpc8308rdb.dts  |    8 ++
 arch/powerpc/platforms/Kconfig        |    7 +-
 arch/powerpc/sysdev/mpc8xxx_gpio.c    |   75 ++++++++++++--
 drivers/dma/Kconfig                   |    2 +-
 drivers/dma/mpc512x_dma.c             |  187 +++++++++++++++++++++------------
 6 files changed, 210 insertions(+), 77 deletions(-)


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
