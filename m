Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 986092C0097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2014 12:16:02 +1100 (EST)
Message-ID: <1389575749.4672.118.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 Jan 2014 12:15:49 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here's one regression fix for 3.13 that I would appreciate if you could still
pull in. It was an "interesting" one to debug, basically it's an old bug that
got somewhat "exposed" by new code breaking the boot on PA Semi boards (yes,
it does appear that some people are still using these !).

Cheers,
Ben.

The following changes since commit f991db1cf1bdca43675b5d2df0af991719727029:

  Merge remote-tracking branch 'agust/merge' into merge (2013-12-30 14:48:27 +1100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 10348f5976830e5d8f74e8abb04a9a057a5e8478:

  powerpc: Check return value of instance-to-package OF call (2014-01-13 09:49:17 +1100)

----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      powerpc: Check return value of instance-to-package OF call

 arch/powerpc/kernel/prom_init.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)
