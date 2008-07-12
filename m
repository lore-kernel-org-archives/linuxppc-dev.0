Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.246])
	by ozlabs.org (Postfix) with ESMTP id 596C2DE0D4
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Jul 2008 04:18:08 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so1294477anc.78
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jul 2008 11:18:06 -0700 (PDT)
Message-ID: <fa686aa40807121118n6d19b2d3s5f08ff04bace2222@mail.gmail.com>
Date: Sat, 12 Jul 2008 12:18:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	"Paul Mackerras" <paulus@samba.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Please pull linux-2.6-mpc52xx tree
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andre Schwarz <andre.schwarz@matrix-vision.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Ben,

Please pull the following patches for MPC5xxx support.

  git://git.secretlab.ca/git/linux-2.6-mpc52xx next

Thanks,
g.

The following changes since commit 0db9360aaa9b95b0cf67f82874809f16e68068eb:
  Nathan Fontenot (1):
        powerpc/pseries: Update numa association of hotplug memory add
for drconf memory

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx next

Andre Schwarz (1):
      powerpc/mpc5200: PCI write combine timer

Grant Likely (3):
      powerpc/mpc5200: Add PSC helpers for bestcomm engine
      powerpc/mpc5200: fix compile warnings in bestcomm driver
      powerpc: Modify MPC52xx maintainers entry to cover all MPC5xxx parts

John Rigby (4):
      powerpc/mpc5121: Update device tree for MPC5121ADS evaluation board
      powerpc/mpc5121: Add clock driver
      powerpc/mpc5121: Add generic board support for MPC5121 platforms
      powerpc/mpc5121: Add support for CPLD on MPC5121ADS board

Jon Smirl (1):
      powerpc/i2c: Convert i2c-mpc into an of_platform driver

Robert P. J. Day (1):
      OpenFirmware: Include <linux/of_i2c.h> from of_i2c.c.

Stephen Rothwell (3):
      powerpc/pata_mpc52xx: use linux/of_platform.h instead of asm
      powerpc/mpc52xx_psc_spi: use linux/of_platform.h instead of asm
      powerpc/mpc5200_wdt: use linux/of_platform.h instead of asm

Wolfgang Grandegger (1):
      powerpc/mpc5200: add missing MSCAN FDT nodes for TQM52xx

 MAINTAINERS                                    |    4 +-
 Makefile                                       |    1 +
 arch/powerpc/boot/dts/mpc5121ads.dts           |  310 ++++++++++-
 arch/powerpc/boot/dts/tqm5200.dts              |   14 +
 arch/powerpc/platforms/512x/Kconfig            |   17 +-
 arch/powerpc/platforms/512x/Makefile           |    4 +-
 arch/powerpc/platforms/512x/clock.c            |  729 ++++++++++++++++++++++++
 arch/powerpc/platforms/512x/mpc5121_ads.c      |   69 +--
 arch/powerpc/platforms/512x/mpc5121_ads.h      |   16 +
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c |  204 +++++++
 arch/powerpc/platforms/512x/mpc5121_generic.c  |   58 ++
 arch/powerpc/platforms/512x/mpc512x.h          |   17 +
 arch/powerpc/platforms/512x/mpc512x_shared.c   |   83 +++
 arch/powerpc/platforms/52xx/mpc52xx_pci.c      |    3 +-
 arch/powerpc/sysdev/bestcomm/bestcomm.c        |    2 +-
 arch/powerpc/sysdev/bestcomm/gen_bd.c          |   95 +++
 arch/powerpc/sysdev/bestcomm/gen_bd.h          |    5 +
 arch/powerpc/sysdev/bestcomm/sram.c            |    2 +-
 arch/powerpc/sysdev/fsl_soc.c                  |  133 -----
 drivers/ata/pata_mpc52xx.c                     |    2 +-
 drivers/i2c/busses/i2c-mpc.c                   |  104 ++--
 drivers/of/of_i2c.c                            |    1 +
 drivers/spi/mpc52xx_psc_spi.c                  |    2 +-
 drivers/watchdog/mpc5200_wdt.c                 |    2 +-
 24 files changed, 1620 insertions(+), 257 deletions(-)
 create mode 100644 arch/powerpc/platforms/512x/clock.c
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_ads.h
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
 create mode 100644 arch/powerpc/platforms/512x/mpc5121_generic.c
 create mode 100644 arch/powerpc/platforms/512x/mpc512x.h
 create mode 100644 arch/powerpc/platforms/512x/mpc512x_shared.c


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
