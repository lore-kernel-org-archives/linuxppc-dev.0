Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0144.outbound.protection.outlook.com [65.55.169.144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F34F61A0024
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 07:28:26 +1000 (AEST)
Date: Wed, 15 Apr 2015 16:28:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Pull request: scottwood/linux.git master
Message-ID: <20150415212812.GA30916@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a fix to a 4.0 regression that causes hugetlb use on PPC
to emit kernel output such as "BUG: non-zero nr_pmds on freeing
mm: 1"

The following changes since commit 39a8804455fb23f09157341d3ba7db6d7ae6ee76:

  Linux 4.0 (2015-04-12 15:12:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git master

for you to fetch changes up to 50c6a665b383cb5839e45d04e36faeeefaffa052:

  powerpc/hugetlb: Call mm_dec_nr_pmds() in hugetlb_free_pmd_range() (2015-04-15 15:24:22 -0500)

----------------------------------------------------------------
Scott Wood (1):
      powerpc/hugetlb: Call mm_dec_nr_pmds() in hugetlb_free_pmd_range()

 arch/powerpc/mm/hugetlbpage.c | 1 +
 1 file changed, 1 insertion(+)
