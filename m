Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4A5EB70D1
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 03:08:11 +1100 (EST)
Date: Fri, 8 Oct 2010 11:04:35 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <Pine.LNX.4.64.1010081102090.19518@localhost.localdomain>
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

Ben,

This isn't critical, but it does fix having the ppc64e_defconfig
build cleanly.

- k

The following changes since commit 6b0cd00bc396daf5c2dcf17a8d82055335341f46:

  Merge branch 'hwpoison-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-mce-2.6 (2010-10-07 13:59:32 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Kumar Gala (1):
      powerpc/ppc64e: Fix link problem when building ppc64e_defconfig

 arch/powerpc/platforms/85xx/smp.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)
