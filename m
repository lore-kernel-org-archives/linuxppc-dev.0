Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38FE4B6F8E
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jul 2011 00:08:54 +1000 (EST)
Date: Mon, 25 Jul 2011 09:08:46 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [GIT PULL] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1107250908150.24107@right.am.freescale.net>
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

[ a few minor fixes ]

The following changes since commit 50d2a4223bb875d1e3a7ee97d40dd03bf31ce1b7:

  powerpc: Copy back TIF flags on return from softirq stack (2011-07-22 13:38:58 +1000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Fabio Baltieri (1):
      powerpc/85xx: fix mpic configuration in CAMP mode

Timur Tabi (1):
      drivers/virt: add missing linux/interrupt.h to fsl_hypervisor.c

 arch/powerpc/platforms/85xx/mpc85xx_ds.c  |    3 ++-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |    5 +++--
 drivers/virt/fsl_hypervisor.c             |    1 +
 3 files changed, 6 insertions(+), 3 deletions(-)
