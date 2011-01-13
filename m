Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09E9AB7043
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Jan 2011 11:07:57 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii
Subject: [git pull] Please pull powerpc.git next branch
Date: Wed, 12 Jan 2011 18:07:53 -0600
Message-Id: <E0B6C38A-A20B-46CA-9FB0-46037D2A2479@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ I know I'm way way way way late, but combo of holidays and getting =
sick.  Please push as these are pretty minor changes ]

The following changes since commit =
0c21e3aaf6ae85bee804a325aa29c325209180fd:

  Merge branch 'for-next' of =
git://git.kernel.org/pub/scm/linux/kernel/git/hch/hfsplus (2011-01-07 =
17:16:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Ilya Yanok (1):
      powerpc/mpc8308: fix USB DR controller initialization

Li Yang (1):
      powerpc/85xx: add e500 HID1 bit definition

Shaohui Xie (1):
      powerpc/fsl_rio: Fix non-standard HID1 register access

Timur Tabi (2):
      powerpc/85xx: fix compatible properties of the P1022DS DMA nodes =
used for audio
      powerpc: fix warning when compiling immap_qe.h

 arch/powerpc/boot/dts/mpc8308rdb.dts      |    2 +-
 arch/powerpc/boot/dts/p1022ds.dts         |    4 ++--
 arch/powerpc/include/asm/immap_qe.h       |   21 +++++++++++++++------
 arch/powerpc/include/asm/reg.h            |    2 ++
 arch/powerpc/include/asm/reg_booke.h      |   14 ++++++++++++++
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |    6 ++++++
 arch/powerpc/platforms/83xx/mpc83xx.h     |    2 ++
 arch/powerpc/platforms/83xx/usb.c         |   21 ++++++++++++++++-----
 arch/powerpc/sysdev/fsl_rio.c             |    2 --
 9 files changed, 58 insertions(+), 16 deletions(-)
