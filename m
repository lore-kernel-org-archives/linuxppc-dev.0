Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0118.outbound.protection.outlook.com [207.46.100.118])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E2DE1A0809
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Nov 2014 15:40:15 +1100 (AEDT)
Date: Mon, 17 Nov 2014 22:39:59 -0600
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Pull request: scottwood/linux.git master
Message-ID: <20141118043959.GA5752@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Kevin Hao <haokexin@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes a crash (introduced in v3.18-rc1) in the FSL MSI driver
when threaded IRQs are enabled.

The following changes since commit 8a97577a5967c1234ccc3bc1b45e4b1a58b39ea8:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux (2014-11-04 11:18:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git master

for you to fetch changes up to d7ce4377494adfaf8afb15ecf4f07d399bbf13d9:

  powerpc/fsl_msi: mark the msi cascade handler IRQF_NO_THREAD (2014-11-17 22:00:30 -0600)

----------------------------------------------------------------
Kevin Hao (1):
      powerpc/fsl_msi: mark the msi cascade handler IRQF_NO_THREAD

 arch/powerpc/sysdev/fsl_msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
