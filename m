Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id CD7AD2C0291
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2013 15:22:57 +1100 (EST)
Message-ID: <1359951767.14701.22.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 04 Feb 2013 15:22:47 +1100
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

Just so that you don't get too bored on your Island here's a patch for
3.8 fixing a nasty bug that affects the new 64T support that was merged
in 3.7. Please apply whenever you have a chance (and an internet
connection !)

Cheers,
Ben.

The following changes since commit 689dfa894c57842a05bf6dc9f97e6bb71ec5f386:

  powerpc: Max next_tb to prevent from replaying timer interrupt (2013-01-29 10:18:16 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to eda8eebdd153c48a4e2a3a3ac3cd9e2e31f5c6b3:

  powerpc/mm: Fix hash computation function (2013-02-04 15:15:08 +1100)

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/mm: Fix hash computation function

 arch/powerpc/mm/hash_low_64.S |   62 +++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 27 deletions(-)
