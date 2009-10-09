Return-Path: <niklaus@ngiger.dyndns.org>
Received: from viefep21-int.chello.at (viefep21-int.chello.at [62.179.121.41])
	by ozlabs.org (Postfix) with ESMTP id 3428EB7B92
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 19:28:50 +1100 (EST)
From: Niklaus Giger <niklaus.giger@member.fsf.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/1] powerpc/40x: Add new PPC440EPx based board HCU5 of
	Netstal Maschinen
Date: Fri,  9 Oct 2009 10:11:04 +0200
Message-Id: <1255075865-4025-1-git-send-email-niklaus.giger@member.fsf.org>
Cc: Niklaus Giger <niklaus.giger@member.fsf.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cc: niklaus.giger@netstal.com,
    jwboyer@linux.vnet.ibm.com,
    mporter@kernel.crashing.org

Patch ist against the "next" branch of
git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git

This is my second board to go into the kernel after the 40x/HCU4.
The HCU5 board is based on the Sequoia board, but has an addition CPLD
with various clocking facilities for our HD and two CAN chips.

As with the HCU4 I will track the mainline kernel.
I use hudson as my continuos integration tool. If I can compile,
start the kernel using NFS and login, I report success.

Niklaus Giger (1):
  powerpc/40x: Add new PPC440EPx based board HCU5 of Netstal Maschinen

 arch/powerpc/boot/dts/hcu5.dts          |  254 +++++++
 arch/powerpc/configs/44x/hcu5_defconfig | 1166 +++++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/Kconfig      |    9 +
 arch/powerpc/platforms/44x/Makefile     |    1 +
 arch/powerpc/platforms/44x/hcu5.c       |  153 ++++
 5 files changed, 1583 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/hcu5.dts
 create mode 100644 arch/powerpc/configs/44x/hcu5_defconfig
 create mode 100644 arch/powerpc/platforms/44x/hcu5.c
