Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7859BB7DCC
	for <linuxppc-dev@ozlabs.org>; Wed, 12 May 2010 17:55:15 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 May 2010 17:46:36 +1000
Message-ID: <1273650396.21352.121.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Please pull this perf event fix from Paulus. Without it, using perf event
can potentially oops the machine at any time.

Thanks !

Cheers,
Ben.

The following changes since commit cea0d767c29669bf89f86e4aee46ef462d2ebae8:
  Linus Torvalds (1):
        Merge branch 'hwmon-for-linus' of git://git.kernel.org/.../jdelvare/staging

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Paul Mackerras (1):
      powerpc/perf_event: Fix oops due to perf_event_do_pending call

 arch/powerpc/include/asm/hw_irq.h |   38 -----------------------
 arch/powerpc/kernel/asm-offsets.c |    1 -
 arch/powerpc/kernel/entry_64.S    |    9 -----
 arch/powerpc/kernel/irq.c         |    6 ----
 arch/powerpc/kernel/time.c        |   60 +++++++++++++++++++++++++++++-------
 5 files changed, 48 insertions(+), 66 deletions(-)
