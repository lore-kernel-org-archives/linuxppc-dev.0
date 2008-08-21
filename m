Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ABC8DDE0B8
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 14:27:50 +1000 (EST)
Date: Wed, 20 Aug 2008 23:27:46 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.27' branch
Message-ID: <Pine.LNX.4.64.0808202327280.11962@blarg.am.freescale.net>
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

Please pull from 'for-2.6.27' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.27

to receive the following updates:

 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |    2 -
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |    8 +++++-
 arch/powerpc/boot/dts/tqm8548.dts          |    3 +-
 arch/powerpc/sysdev/qe_lib/ucc_fast.c      |    4 +++
 drivers/serial/Kconfig                     |   36 -----------------------------
 5 files changed, 14 insertions(+), 39 deletions(-)

Kumar Gala (2):
      powerpc: Fix whitespace merge in mpc8641 hpcn device tree
      serial/cpm_uart: Remove dead Kconfig options

Timur Tabi (1):
      powerpc: fix memory leaks in QE library

Wolfgang Grandegger (1):
      powerpc/85xx: TQM8548: DTS file fixes and cleanup
