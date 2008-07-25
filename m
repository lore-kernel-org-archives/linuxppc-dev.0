Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A007DDF78
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 09:11:23 +1000 (EST)
Subject: [git pull] Please pull from powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Date: Sat, 26 Jul 2008 09:11:13 +1000
Message-Id: <1217027473.11188.120.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linus !

Please pull from:
﻿
﻿git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

To get one patch that fixes a boot problem introduced by yesterday's
serie.

Thanks !
Ben.

 arch/powerpc/kernel/cputable.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Nathan Lynch (1):
      powerpc: Fix boot problem due to AT_BASE_PLATFORM change
