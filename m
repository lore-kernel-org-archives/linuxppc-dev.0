Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8AF0BDDDF9
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 14:57:09 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Tue, 05 May 2009 14:55:17 +1000
Message-Id: <1241499317.10504.59.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	akpm <akpm@linux-foundation.org>,
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

Here are a few things still for .30 for you to merge !

Cheers,
Ben.

The following changes since commit 091438dd5668396328a3419abcbc6591159eb8d1:
  Linus Torvalds (1):
        Linux 2.6.30-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (1):
      powerpc: Fix setting of oprofile cpu type

Grant Likely (1):
      powerpc: Update MPC5xxx and Xilinx Virtex maintainer entries

Michael Wolf (1):
      powerpc adjust oprofile_cpu_type version 3

 MAINTAINERS                    |    4 ++--
 arch/powerpc/kernel/cputable.c |   15 ++++++++++-----
 2 files changed, 12 insertions(+), 7 deletions(-)
