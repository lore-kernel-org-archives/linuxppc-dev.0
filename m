Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C6081A0357
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jun 2014 19:48:50 +1000 (EST)
Message-ID: <1402912122.7661.38.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Jun 2014 19:48:42 +1000
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

This is a single revert for a patch I should have never merged in the
first place had I reviewed things with a clear mind at the time :-(

Cheers,
Ben.

The following changes since commit
7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git next

for you to fetch changes up to 68986c9f0f4552c34c248501eb0c690553866d6e:

  Revert "offb: Add palette hack for little endian" (2014-06-16 19:45:45
+1000)

----------------------------------------------------------------
Benjamin Herrenschmidt (1):
      Revert "offb: Add palette hack for little endian"

 drivers/video/fbdev/offb.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)
