Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9329F1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Dec 2009 09:46:11 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 01 Dec 2009 09:46:00 +1100
Message-ID: <1259621160.2076.155.camel@pasglop>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev list <linuxppc-dev@lists.ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus

Please pull one patch from Becky to fix a build breakage in 2.6.32 with
CONFIG_DEBUG_HIGHMEM. This is, I believe, the same patch that went
into ARM to fix the same issue.

Cheers,
Ben.

The following changes since commit a8a8a669ea13d792296737505adc43ccacf3a648:
  Linus Torvalds (1):
        Merge branch 'i2c-pnx-fixes' of git://git.fluff.org/bjdooks/linux

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Becky Bruce (1):
      powerpc: Fix DEBUG_HIGHMEM build break from d4515646699

 arch/powerpc/include/asm/kmap_types.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)
