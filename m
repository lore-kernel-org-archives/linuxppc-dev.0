Return-Path: <geoff@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1E0D5B6F71
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Nov 2011 13:19:43 +1100 (EST)
From: Geoff Levand <geoff@infradead.org>
Date: Tue, 8 Nov 2011 17:51:30 -0800
Subject: [PATCH 0/2] PS3 fixes for 3.2
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <E1RNxlF-0000wf-Rh@casper.infradead.org>
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
 Andre Heider <a.heider@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

Here are two fixes for PS3.  Please apply for 3.2.

-Geoff

The following changes

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-powerpc


Geoff Levand (2):
  powerpc/ps3: Fix lost SMP IPIs
  powerpc/ps3: Fix SMP lockdep boot warning

 arch/powerpc/platforms/ps3/interrupt.c |   23 +++++++++++-
 arch/powerpc/platforms/ps3/platform.h  |    1 +
 arch/powerpc/platforms/ps3/smp.c       |   62 ++++++++++++++++---------------
 3 files changed, 55 insertions(+), 31 deletions(-)
