Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EA695B7040
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2012 13:38:38 +1000 (EST)
Message-ID: <1334201907.2984.70.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2012 13:38:27 +1000
Content-Type: text/plain; charset="UTF-8"
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

Here are fixes for two nasty regression affecting powerpc in 3.4.

Please apply,

Cheers,
Ben.

The following changes since commit b1a808ff436343956a6ae63178ea1810c5e5a3a1:

  Merge branch 'for-next' of git://gitorious.org/kernel-hsi/kernel-hsi (2012-04-02 09:50:40 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to fae2e0fb24c61ca68c98d854a34732549ebc1854:

  powerpc: Fix typo in runlatch code (2012-04-11 10:42:15 +1000)

----------------------------------------------------------------
Benjamin Herrenschmidt (2):
      powerpc: Fix page fault with lockdep regression
      powerpc: Fix typo in runlatch code

 arch/powerpc/kernel/entry_32.S |   39 +++++++++++++++++++++------------------
 arch/powerpc/kernel/process.c  |    4 ++--
 2 files changed, 23 insertions(+), 20 deletions(-)
