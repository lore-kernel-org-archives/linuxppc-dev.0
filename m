Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 991D9DDE33
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 16:57:45 +1100 (EST)
Date: Mon, 19 Nov 2007 23:56:23 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.24' branch
Message-ID: <Pine.LNX.4.64.0711192355460.1265@blarg.am.freescale.net>
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

Please pull from 'for-2.6.24' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.24

to receive the following updates:

 Documentation/powerpc/booting-without-of.txt |    5 -
 arch/powerpc/boot/dts/mpc832x_mds.dts        |    9 -
 arch/powerpc/boot/dts/mpc8544ds.dts          |   20 ++--
 arch/powerpc/boot/dts/mpc8572ds.dts          |  108 ++++++++++++++++++++---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |  126 ++++++++++++++++++++++-----
 arch/powerpc/platforms/83xx/mpc832x_mds.c    |    7 -
 arch/powerpc/platforms/83xx/mpc836x_mds.c    |   31 ++++++
 arch/powerpc/platforms/83xx/usb.c            |    8 -
 8 files changed, 254 insertions(+), 60 deletions(-)

Cyrill Gorcunov (1):
      [POWERPC] Fix potential NULL dereference

Kim Phillips (4):
      [POWERPC] 83xx: mpc832x mds: Fix board PHY reset code
      [POWERPC] 83xx: Fix 2nd UCC entry in mpc832x_mds.dts
      [POWERPC] Document rgmii-rxid and rgmii-txid phy-connection-types
      [POWERPC] 83xx: Handle mpc8360 rev. 2.1 RGMII timing erratum

Kumar Gala (1):
      [POWERPC] Fix device tree interrupt map for Freescale ULI1575 boards
