Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0FDFEDDED0
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 23:50:09 +1000 (EST)
Date: Mon, 28 Jul 2008 08:50:04 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Please pull from 'powerpc-next' branch (for 2.6.27)(updated)
In-Reply-To: <Pine.LNX.4.64.0807280752420.22887@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0807280849280.3813@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0807280752420.22887@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'powerpc-next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git powerpc-next

Laurent informed me I missed one CPM related patch:
'cpm2: Rework baud rate generators configuration to support external
clocks.'

- k

to receive the following updates:

 Documentation/powerpc/dts-bindings/fsl/cpm_qe/serial.txt |   11
 arch/powerpc/platforms/8xx/Kconfig                       |   10
 arch/powerpc/platforms/Kconfig                           |    3
 arch/powerpc/sysdev/cpm1.c                               |  267 ++++++++++++++-
 arch/powerpc/sysdev/cpm2.c                               |   45 --
 arch/powerpc/sysdev/cpm_common.c                         |  123 ++++++
 arch/powerpc/sysdev/rtc_cmos_setup.c                     |   23 -
 drivers/serial/cpm_uart/cpm_uart.h                       |   11
 drivers/serial/cpm_uart/cpm_uart_core.c                  |   66 +++
 include/asm-powerpc/cpm.h                                |    3
 include/asm-powerpc/cpm2.h                               |   46 +-
 11 files changed, 544 insertions(+), 64 deletions(-)

Anton Vorontsov (1):
      powerpc: rtc_cmos_setup: assign interrupts only if there is i8259 PIC

Jochen Friedrich (1):
      powerpc: implement GPIO LIB API on CPM1 Freescale SoC.

Laurent Pinchart (4):
      cpm2: Implement GPIO LIB API on CPM2 Freescale SoC.
      cpm_uart: Modem control lines support
      cpm_uart: Add generic clock API support to set baudrates
      cpm2: Rework baud rate generators configuration to support external clocks.
