Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id D56E4DDFF1
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 05:46:52 +1000 (EST)
Message-Id: <20070423193538.576702568@arndb.de>
Date: Mon, 23 Apr 2007 21:35:38 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 00/10] non-spufs updates for cell platforms
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These are mostly about power management and other features of specific
IBM blades. Please pull from

ssh://master.kernel.org/pub/scm/linux/kernel/git/arnd/cell-2.6.git for-2.6.22

	Arnd <><

---

 arch/powerpc/configs/cell_defconfig       |   57 ++++-----
 arch/powerpc/oprofile/op_model_cell.c     |    1
 arch/powerpc/platforms/cell/cbe_cpufreq.c |   81 +++++++++++++
 arch/powerpc/platforms/cell/cbe_regs.c    |  165 +++++++++++++++++++++------
 arch/powerpc/platforms/cell/cbe_regs.h    |    5
 arch/powerpc/platforms/cell/cbe_thermal.c |  177 +++++++++++++++++++++++++++---
 arch/powerpc/platforms/cell/ras.c         |  160 +++++++++++++++++++++++++++
 arch/powerpc/sysdev/pmi.c                 |   29 +---
 include/asm-powerpc/cell-pmu.h            |    5
 include/asm-powerpc/prom.h                |   11 +
 10 files changed, 581 insertions(+), 110 deletions(-)
