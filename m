Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7A5602C008C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 14:42:21 +1000 (EST)
Message-ID: <1372567331.18612.97.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 30 Jun 2013 14:42:11 +1000
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

Earlier today I mentioned that while we had fixed the kernel crashes,
EEH error recovery didn't always recover... It appears that I had
a fix for that already in powerpc-next (with a stable CC).

I cherry-picked it today and did a few tests and it seems that things
now work quite well. The patch is also pretty simple, so I see no reason
to wait before merging it.

Please pull.

Cheers,
Ben.

The following changes since commit 6c355beafdbd0a62add3a3d89825ca87cf8ecec0:

  Merge branch 'merge' of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc (2013-06-29 17:02:48 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to ea461abf61753b4b79e625a7c20650105b990f21:

  powerpc/eeh: Fix fetching bus for single-dev-PE (2013-06-30 14:08:34 +1000)

----------------------------------------------------------------
Gavin Shan (1):
      powerpc/eeh: Fix fetching bus for single-dev-PE

 arch/powerpc/platforms/pseries/eeh_pe.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
