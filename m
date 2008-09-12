Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B15AADDF35
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Sep 2008 06:47:26 +1000 (EST)
Date: Fri, 12 Sep 2008 15:47:21 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.27'
Message-ID: <Pine.LNX.4.64.0809121546530.6192@blarg.am.freescale.net>
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

 arch/powerpc/boot/dts/mpc8610_hpcd.dts |    8 +--
 arch/powerpc/sysdev/cpm1.c             |   74 +++++++++++++++++++++++----------
 2 files changed, 56 insertions(+), 26 deletions(-)

Jochen Friedrich (1):
      powerpc/cpm1: Fix race condition in CPM1 GPIO library.

Timur Tabi (1):
      powerpc: fix interrupt values for DMA2 in MPC8610 HPCD device tree
