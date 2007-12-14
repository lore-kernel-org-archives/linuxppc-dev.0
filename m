Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 05B94DE27E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 16:05:51 +1100 (EST)
Date: Thu, 13 Dec 2007 23:04:06 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.24' branch
Message-ID: <Pine.LNX.4.64.0712132304000.8439@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for-2.6.24' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.24

to receive the following updates:

 arch/powerpc/configs/mpc8272_ads_defconfig |    6 +++---
 arch/powerpc/configs/pq2fads_defconfig     |    6 +++---
 arch/powerpc/kernel/ppc_ksyms.c            |   12 ------------
 arch/powerpc/math-emu/op-2.h               |    3 ++-
 arch/powerpc/sysdev/cpm2_common.c          |    3 +--
 drivers/net/fs_enet/mac-scc.c              |    2 +-
 include/asm-powerpc/commproc.h             |    3 ---
 7 files changed, 10 insertions(+), 25 deletions(-)

Jochen Friedrich (2):
      [POWERPC] Fix typo #ifdef -> #ifndef
      [POWERPC] Kill non-existent symbols from ksyms and commproc.h

Liu Yu (1):
      [POWERPC] Fix rounding bug in emulation for double float operating

Scott Wood (2):
      [POWRPC] CPM2: Eliminate section mismatch warning in cpm2_reset().
      [POWERPC] 82xx: mpc8272ads, pq2fads: Update defconfig with CONFIG_FS_ENET_MDIO_FCC
