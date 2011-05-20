Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1402B6F6C
	for <linuxppc-dev@ozlabs.org>; Sat, 21 May 2011 00:35:52 +1000 (EST)
Date: Fri, 20 May 2011 09:35:44 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <alpine.LFD.2.00.1105200934580.11641@right.am.freescale.net>
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

A bug/erratum fix, and a 2 long standing SRIO patches...

The following changes since commit 208b3a4c196e733b9cec006dc132cfc149b2810a:

  powerpc: Fix hard CPU IDs detection (2011-05-20 17:50:18 +1000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Shaohui Xie (2):
      powerpc/fsl_rio: move machine_check handler
      powerpc/fsl_rio: Error interrupt handler for sRIO on MPC85xx

Shengzhou Liu (1):
      powerpc/fsl_lbc: Add workaround for ELBC-A001 erratum

 arch/powerpc/include/asm/fsl_lbc.h |    2 +
 arch/powerpc/include/asm/rio.h     |    5 ++
 arch/powerpc/kernel/traps.c        |   13 +++++
 arch/powerpc/sysdev/fsl_lbc.c      |    9 +++-
 arch/powerpc/sysdev/fsl_rio.c      |  100 ++++++++++++++++++++++++++++-------
 5 files changed, 107 insertions(+), 22 deletions(-)
