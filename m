Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A9F84B725D
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 12:15:31 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: Linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH 0/3] MPC85xx compile fixes
Date: Tue, 31 Aug 2010 04:15:19 +0200
Message-Id: <1283220922-20369-1-git-send-email-agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While trying to compile a recent git kernel on my e500v2 box, I came
across some pretty simple compilation bugs.

Since I have no idea which tree those go through, I'm sending them to
you, but please coordinate who takes them in.

Also, it might be useful to set up a make defconfig machine that does
regression testing for booke builds. These really shouldn't be caught
by me in the kvm.git tree :).

Alexander Graf (3):
  PPC: s/mtmsrd/MTMSR in ldstfp.S
  PPC: Fix compilation of fsl_rio.c
  PPC: Fix compilation of mpc85xx_mds.c

 arch/powerpc/lib/ldstfp.S                 |   32 ++++++++++++++--------------
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
 arch/powerpc/sysdev/fsl_rio.c             |    2 +-
 3 files changed, 18 insertions(+), 17 deletions(-)
