Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 62AC6DDDFD
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 02:52:50 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so155778anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 07:52:47 -0800 (PST)
Message-ID: <fa686aa40801170752j5e41b1cbs82cd21bf47c7d92e@mail.gmail.com>
Date: Thu, 17 Jan 2008 08:52:45 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: Patches added to master/for-2.6.25 branch of powerpc.git
In-Reply-To: <18318.56299.476711.644917@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <18318.56299.476711.644917@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul, can you also please pull the following 52xx changes?

Thanks,
g.

The following changes since commit 52920df4aa9dd25836b8ed4dc0b177ea14c09e53:
  Paul Mackerras (1):
        Merge branch 'for-2.6.25' of
master.kernel.org:/.../olof/pasemi into for-2.6.25

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git for-2.6.25

Grant Likely (1):
      [POWERPC] mpc5200: eliminate mpc52xx_*_map_*() functions.

Marian Balakowicz (9):
      Add 'fsl, lpb' bus type for MPC5200 LocalPlus Bus
      Add common mpc52xx_setup_pci() routine
      TQM5200 DTS
      TQM5200 defconfig
      CM5200 DTS
      CM5200 defconfig
      Promess Motion-PRO DTS
      Promess Motion-PRO defconfig
      Add generic support for simple MPC5200 based boards

 arch/powerpc/boot/dts/cm5200.dts             |  236 +++++
 arch/powerpc/boot/dts/lite5200.dts           |    2 +-
 arch/powerpc/boot/dts/lite5200b.dts          |    2 +-
 arch/powerpc/boot/dts/motionpro.dts          |  309 ++++++
 arch/powerpc/boot/dts/tqm5200.dts            |  184 ++++
 arch/powerpc/configs/cm5200_defconfig        | 1031 ++++++++++++++++++++
 arch/powerpc/configs/motionpro_defconfig     |  989 +++++++++++++++++++
 arch/powerpc/configs/tqm5200_defconfig       | 1306 ++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/Kconfig          |   22 +-
 arch/powerpc/platforms/52xx/Makefile         |    1 +
 arch/powerpc/platforms/52xx/lite5200.c       |   22 +-
 arch/powerpc/platforms/52xx/lite5200_pm.c    |    6 +-
 arch/powerpc/platforms/52xx/mpc5200_simple.c |   85 ++
 arch/powerpc/platforms/52xx/mpc52xx_common.c |   63 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c    |   14 +
 arch/powerpc/platforms/52xx/mpc52xx_pic.c    |    8 +-
 arch/powerpc/platforms/52xx/mpc52xx_pm.c     |    8 +-
 drivers/spi/mpc52xx_psc_spi.c                |    9 +-
 include/asm-powerpc/mpc52xx.h                |    7 +-
 19 files changed, 4234 insertions(+), 70 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/cm5200.dts
 create mode 100644 arch/powerpc/boot/dts/motionpro.dts
 create mode 100644 arch/powerpc/boot/dts/tqm5200.dts
 create mode 100644 arch/powerpc/configs/cm5200_defconfig
 create mode 100644 arch/powerpc/configs/motionpro_defconfig
 create mode 100644 arch/powerpc/configs/tqm5200_defconfig
 create mode 100644 arch/powerpc/platforms/52xx/mpc5200_simple.c

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
