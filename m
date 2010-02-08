Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6518FB7D14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Feb 2010 17:16:17 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 08 Feb 2010 17:16:06 +1100
Message-ID: <1265609766.8287.234.camel@pasglop>
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

Hi Linus !

Here's a small regression fix that should still make it into .33

Cheers,
Ben.

The following changes since commit 6339204ecc2aa2067a99595522de0403f0854bb8:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../viro/vfs-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Mark Nelson (1):
      powerpc/pseries: Fix kexec regression caused by CPPR tracking

 arch/powerpc/platforms/pseries/xics.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)
