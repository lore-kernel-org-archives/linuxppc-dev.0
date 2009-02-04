Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 253CFDDED1
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 07:57:10 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so995607yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Feb 2009 12:57:09 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 4 Feb 2009 13:57:08 -0700
Message-ID: <fa686aa40902041257v641546cen5c95a8283aae8f9f@mail.gmail.com>
Subject: Please pull 'next' branch of linux-2.6-mpc52xx.git
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

And I really mean -next this time.  :-)

The following changes since commit b1792e367053968f2ddb48bc911d314143ce6242:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../jbarnes/pci-2.6

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-mpc52xx.git next

Grant Likely (7):
      powerpc/5200: Stop using device_type and port-number properties
      powerpc/5200: Trim cruft from device trees
      powerpc/5200: Don't specify IRQF_SHARED in PSC UART driver
      powerpc/5200: Remove pr_debug() from hot paths in irq driver
      powerpc/5200: Refactor mpc5200 interrupt controller driver
      powerpc/5200: Rework GPT driver to also be an IRQ controller
      powerpc/5200: Add support for the Media5200 board from Freescale

Grzegorz Bernacki (1):
      powerpc/5200: Add support for the digsy MTC board.

 arch/powerpc/boot/Makefile                   |    4 +-
 arch/powerpc/boot/dts/cm5200.dts             |   49 +---
 arch/powerpc/boot/dts/digsy_mtc.dts          |  254 +++++++++++++++
 arch/powerpc/boot/dts/lite5200.dts           |   52 +---
 arch/powerpc/boot/dts/lite5200b.dts          |   63 +---
 arch/powerpc/boot/dts/media5200.dts          |  318 +++++++++++++++++++
 arch/powerpc/boot/dts/motionpro.dts          |   42 +--
 arch/powerpc/boot/dts/pcm030.dts             |  182 ++++-------
 arch/powerpc/boot/dts/tqm5200.dts            |   32 +--
 arch/powerpc/platforms/52xx/Kconfig          |   12 +-
 arch/powerpc/platforms/52xx/Makefile         |    3 +-
 arch/powerpc/platforms/52xx/media5200.c      |  273 ++++++++++++++++
 arch/powerpc/platforms/52xx/mpc5200_simple.c |    1 +
 arch/powerpc/platforms/52xx/mpc52xx_gpio.c   |   85 -----
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c    |  435 ++++++++++++++++++++++++++
 arch/powerpc/platforms/52xx/mpc52xx_pic.c    |  170 ++++-------
 drivers/net/fec_mpc52xx.c                    |    6 +-
 drivers/serial/mpc52xx_uart.c                |   40 +--
 18 files changed, 1476 insertions(+), 545 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/digsy_mtc.dts
 create mode 100644 arch/powerpc/boot/dts/media5200.dts
 create mode 100644 arch/powerpc/platforms/52xx/media5200.c
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_gpt.c


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
