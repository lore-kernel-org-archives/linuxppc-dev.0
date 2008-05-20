Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5CD59DDF17
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 15:43:43 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH v2 0/4] Fixes for 2.6.26
Date: Tue, 20 May 2008 00:43:34 -0500
Message-Id: <1211262218-13949-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for-2.6.26' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.26

to receive the following updates:

 arch/powerpc/boot/.gitignore          |    8 +++-----
 arch/powerpc/boot/Makefile            |    6 ++++--
 arch/powerpc/boot/dts/mpc8377_mds.dts |   18 +++++++++++++-----
 lib/lmb.c                             |    3 ++-
 4 files changed, 22 insertions(+), 13 deletions(-)

Kumar Gala (4):
      lmb: Fix compile warning
      [POWERPC] Remove generated files on make clean
      [POWERPC] Update arch/powerpc/boot/.gitignore
      [POWERPC] Fix mpc8377_mds.dts DMA nodes to match spec
