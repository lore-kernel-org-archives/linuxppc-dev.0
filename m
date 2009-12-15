Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 53DE8B6F08
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 07:20:15 +1100 (EST)
Date: Tue, 15 Dec 2009 14:20:04 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <Pine.LNX.4.64.0912151419170.32516@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following changes since
commit e090aa80321b64c3b793f3b047e31ecf1af9538d:
  Benjamin Herrenschmidt (1):
        powerpc: Fix usage of 64-bit instruction in 32-bit altivec code

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Anton Vorontsov (4):
      powerpc/fsl_pci: Fix P2P bridge handling for MPC83xx PCIe controllers
      powerpc/83xx/suspend: Clear deep_sleeping after devices resume
      powerpc/83xx/suspend: Save and restore SICRL, SICRH and SCCR
      powerpc/83xx: Add power management support for MPC8315E-RDB boards

Dmitry Eremin-Solenikov (4):
      powerpc/83xx: mpc8349emitx - add gpio controller declarations
      powerpc/83xx: mpc8349emitx - populate I2C busses in device tree
      powerpc/83xx: mpc8349emitx - add OF descriptions of LocalBus devices
      powerpc/83xx: mpc8349emitx - add leds-gpio binding

Felix Radensky (1):
      powerpc/85xx: Workaround MPC8572/MPC8536 GPIO 1 errata.

Mark Ware (1):
      powerpc/cpm2_pic: Allow correct flow_types for port C interrupts

Peter Korsgaard (1):
      powerpc/gpio: support gpio_to_irq()

Sebastian Andrzej Siewior (1):
      powerpc/fsl: try to explain why the interrupt numbers are off by 16

 Documentation/powerpc/dts-bindings/fsl/mpic.txt |   42 ++++++++++++
 arch/powerpc/boot/dts/mpc8315erdb.dts           |   27 ++++++++
 arch/powerpc/boot/dts/mpc8349emitx.dts          |   82 ++++++++++++++++++++++-
 arch/powerpc/include/asm/gpio.h                 |    5 +-
 arch/powerpc/platforms/83xx/suspend.c           |   52 ++++++++++++++-
 arch/powerpc/sysdev/cpm2_pic.c                  |   28 ++++++--
 arch/powerpc/sysdev/fsl_pci.c                   |    8 ++-
 arch/powerpc/sysdev/mpc8xxx_gpio.c              |   21 ++++++-
 8 files changed, 248 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/mpic.txt
