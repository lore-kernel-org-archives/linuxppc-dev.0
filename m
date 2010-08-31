Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1A1C6B710A
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Aug 2010 15:57:14 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 31 Aug 2010 15:56:38 +1000
Message-ID: <1283234198.2151.15.camel@pasglop>
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

Here's a few small fixes, one is an important fix for a nasty regression
breaking pseries machine running under hypervisor... oops !

Cheers,
Ben.

The following changes since commit 2bfc96a127bc1cc94d26bfaa40159966064f9c8c:
  Linus Torvalds (1):
        Linux 2.6.36-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Matthew McClintock (1):
      powerpc/kexec: Adds correct calling convention for kexec purgatory

Michael Neuling (1):
      powerpc: Don't use kernel stack with translation off

Paul Mackerras (1):
      powerpc/perf_event: Reduce latency of calling perf_event_do_pending

 arch/powerpc/kernel/head_64.S |   12 +++++++++---
 arch/powerpc/kernel/misc_32.S |    3 +++
 arch/powerpc/kernel/time.c    |   23 +++++++++++------------
 3 files changed, 23 insertions(+), 15 deletions(-)
