Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 72879B7DBE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 04:27:15 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.1005132327390.30346@localhost.localdomain>
Date: Mon, 17 May 2010 13:27:08 -0500
Message-Id: <1A1083A4-5486-484B-BC31-760AA72C8126@kernel.crashing.org>
References: <Pine.LNX.4.64.1005132327390.30346@localhost.localdomain>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 13, 2010, at 11:28 PM, Kumar Gala wrote:

> The following changes since commit =
131c6c9eddfa252e376edb4aeff9c7fe1b96a798:
>  Benjamin Herrenschmidt (1):
>        Merge commit 'kumar/merge' into merge
>=20
> are available in the git repository at:
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge
>=20
> Kumar Gala (1):
>      powerpc/fsl-booke: Move loadcam_entry back to asm code to fix SMP =
ftrace
>=20
> Li Yang (1):
>      powerpc/fsl-booke: Fix InstructionTLBError execute permission =
check
>=20
> arch/powerpc/kernel/asm-offsets.c    |    8 ++++++++
> arch/powerpc/kernel/head_fsl_booke.S |   13 ++++++++++---
> arch/powerpc/mm/fsl_booke_mmu.c      |   25 +++----------------------
> arch/powerpc/mm/mmu_decl.h           |   10 +++++++++-
> arch/powerpc/mm/tlb_nohash_low.S     |   28 =
++++++++++++++++++++++++++++
> 5 files changed, 58 insertions(+), 26 deletions(-)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

I've just moved these into my next branch.  Will send them to stable =
once they get pulled into .35.

- k=
