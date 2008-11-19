Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF117DDDD4
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 08:13:15 +1100 (EST)
Date: Wed, 19 Nov 2008 15:13:09 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'merge' branch (for 2.6.28)
Message-ID: <Pine.LNX.4.64.0811191512490.15955@blarg.am.freescale.net>
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

Please pull from 'merge' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git merge

to receive the following updates:

 arch/powerpc/boot/dts/mpc832x_rdb.dts          |    4 ++--
 arch/powerpc/boot/dts/mpc8572ds.dts            |    2 +-
 arch/powerpc/configs/86xx/gef_sbc610_defconfig |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

Martyn Welch (1):
      powerpc: Use generic PHY driver for Marvell 88E1111 PHY on GE Fanuc SBC610

Michael Barkowski (1):
      powerpc/mpc832x_rdb: fix swapped ethernet ids

Trent Piepho (1):
      powerpc/85xx: L2 cache size wrong in 8572DS dts
