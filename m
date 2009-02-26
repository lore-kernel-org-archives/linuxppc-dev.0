Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D809DDDA5
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Feb 2009 15:07:39 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 26 Feb 2009 15:07:24 +1100
Message-Id: <1235621244.8805.340.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linus !

Please pull a few regression fixes for powerpc.

Cheers,
Ben.

The following changes since commit 169d418b127b98a3e464e9c4b807ad083760f98c:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../tiwai/sound-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Mark Nelson (2):
      powerpc: Fix 64bit memcpy() regression
      powerpc: Fix 64bit __copy_tofrom_user() regression

Michael Neuling (1):
      powerpc: Fix load/store float double alignment handler

 arch/powerpc/kernel/align.c    |   29 +++++++++++++----------------
 arch/powerpc/lib/copyuser_64.S |   38 +++++++++++++++++++++++++++++++-------
 arch/powerpc/lib/memcpy_64.S   |   26 ++++++++++++++++++++------
 3 files changed, 64 insertions(+), 29 deletions(-)
