Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CDF52B7086
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 18:01:11 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3C3E5DDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 18:01:10 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Thu, 16 Jul 2009 18:00:58 +1000
Message-Id: <1247731258.27937.44.camel@pasglop>
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

Here are a couple of fixes for powerpc for 2.6.31.

The following changes since commit e9e961c9a818a2f24711af493b907a8e40a69efc:
  Linus Torvalds (1):
        Merge branch 'i2c-for-2631-rc3' of git://aeryn.fluff.org.uk/bjdooks/linux

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Andreas Schwab (1):
      powerpc: Fix another bug in move of altivec code to vector.S

Dave Kleikamp (1):
      powerpc: Fix booke user_disable_single_step()

 arch/powerpc/kernel/ptrace.c |   17 +++++++++--------
 arch/powerpc/kernel/vector.S |    6 +++---
 2 files changed, 12 insertions(+), 11 deletions(-)
