Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA2E1DDEFF
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Mar 2008 02:06:22 +1100 (EST)
Date: Fri, 7 Mar 2008 09:03:09 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.25' branch
Message-ID: <Pine.LNX.4.64.0803070902220.14943@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for-2.6.25' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.25

These are fixes to forward on to linus (based on his tree).

to receive the following updates:

 arch/powerpc/boot/dts/mpc8377_mds.dts           |   70 ++
 arch/powerpc/boot/dts/mpc8378_mds.dts           |   70 ++
 arch/powerpc/boot/dts/mpc8379_mds.dts           |   70 ++
 arch/powerpc/boot/wrapper                       |    6
 arch/powerpc/configs/adder875-redboot_defconfig |  798 -----------------------
 arch/powerpc/configs/adder875-uboot_defconfig   |  798 -----------------------
 arch/powerpc/configs/adder875_defconfig         |  813 ++++++++++++++++++++++++
 arch/powerpc/kernel/head_8xx.S                  |   30
 arch/powerpc/platforms/83xx/mpc837x_mds.c       |    8
 arch/powerpc/sysdev/qe_lib/qe.c                 |    2
 include/asm-powerpc/pgtable-ppc32.h             |    8
 11 files changed, 1055 insertions(+), 1618 deletions(-)

Li Yang (2):
      [POWERPC] 83xx: Fix wrong USB phy type in mpc837xmds dts
      [POWERPC] 83xx: Add local bus device nodes to MPC837xMDS device trees.

Scott Wood (1):
      [POWERPC] 8xx: Fix wrapper platform for adder875, and combine defconfigs.

Timur Tabi (1):
      [POWERPC] QE: Fix QE firmware uploading limit

Vitaly Bordug (1):
      [POWERPC] 8xx: fix swap
