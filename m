Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 980991A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 17:57:42 +1100 (AEDT)
Date: Fri, 4 Mar 2016 00:57:32 -0600
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Message-ID: <20160304065732.GA17267@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Pull request: scottwood/linux.git fixes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes a regression that causes any usage of hugetlb
on e5500 to oops.

The following changes since commit fb822e6076d972691c5dd33431c10f82dda94ae9:

  powerpc/hw_breakpoint: Fix oops when destroying hw_breakpoint event (2016-03-03 22:06:08 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git fixes

for you to fetch changes up to 37c5e942bb2eedd98c1cd1fa1f94d79f6b830c38:

  powerpc/fsl-book3e: Avoid lbarx on e5500 (2016-03-03 23:43:05 -0600)

----------------------------------------------------------------
Scott Wood (1):
      powerpc/fsl-book3e: Avoid lbarx on e5500

 arch/powerpc/mm/hugetlbpage-book3e.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)
