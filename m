Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7874FB7E6C
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 14:28:11 +1000 (EST)
Date: Thu, 13 May 2010 23:28:06 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <Pine.LNX.4.64.1005132327390.30346@localhost.localdomain>
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

The following changes since commit 131c6c9eddfa252e376edb4aeff9c7fe1b96a798:
  Benjamin Herrenschmidt (1):
        Merge commit 'kumar/merge' into merge

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Kumar Gala (1):
      powerpc/fsl-booke: Move loadcam_entry back to asm code to fix SMP ftrace

Li Yang (1):
      powerpc/fsl-booke: Fix InstructionTLBError execute permission check

 arch/powerpc/kernel/asm-offsets.c    |    8 ++++++++
 arch/powerpc/kernel/head_fsl_booke.S |   13 ++++++++++---
 arch/powerpc/mm/fsl_booke_mmu.c      |   25 +++----------------------
 arch/powerpc/mm/mmu_decl.h           |   10 +++++++++-
 arch/powerpc/mm/tlb_nohash_low.S     |   28 ++++++++++++++++++++++++++++
 5 files changed, 58 insertions(+), 26 deletions(-)
