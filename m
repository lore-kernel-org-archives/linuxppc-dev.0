Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhFmL1nDDzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 14:20:17 +1000 (AEST)
Date: Mon, 28 Aug 2017 23:20:05 -0500
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org,
 Matthew Weber <matthew.weber@rockwellcollins.com>
Message-ID: <20170829042005.2cdf3udnkermom7m@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Pull request: scottwood/linux.git next
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following changes since commit d1d0d5ffb3006eaf9b5f41c89fe801e032cbbfe4:

  powerpc/64: Optimise set/clear of CTRL[RUN] (runlatch) (2017-08-23 23:48:38 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to a4e89ffb59235fd11d27107dea3efa4562ac0a12:

  powerpc/e6500: Update machine check for L1D cache err (2017-08-28 23:15:32 -0500)

----------------------------------------------------------------
Matt Weber (1):
      powerpc/e6500: Update machine check for L1D cache err

 arch/powerpc/kernel/traps.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)
