Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C690B2C00A7
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2012 15:37:20 +1100 (EST)
Message-ID: <1353472633.17856.37.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Nov 2012 15:37:13 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
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

Here are small 52xx fixes that Anatolij asked me to pull a while back
and that I completely missed. The stuff is local to that platform code,
and was in next for a while, so it should still go into 3.7.

Thanks,
Ben.

The following changes since commit 8c23f406c6d86808726ace580657186bc3b44587:

  Merge git://git.kernel.org/pub/scm/virt/kvm/kvm (2012-11-01 08:27:02 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to d6dc24613c222f9057131ccbd5264a10bcba9f97:

  Merge remote-tracking branch 'agust/merge' into merge (2012-11-21 13:24:49 +1100)

----------------------------------------------------------------

Anatolij Gustschin (1):
      powerpc/mpc5200: move lpbfifo node and fix its interrupt property

Benjamin Herrenschmidt (1):
      Merge remote-tracking branch 'agust/merge' into merge

Eric Millbrandt (1):
      powerpc/pcm030: add pcm030-audio-fabric to dts

Wolfram Sang (1):
      powerpc: 52xx: nop out unsupported critical IRQs

 arch/powerpc/boot/dts/mpc5200b.dtsi       |    6 ++++++
 arch/powerpc/boot/dts/o2d.dtsi            |    6 ------
 arch/powerpc/boot/dts/pcm030.dts          |    7 ++++++-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    9 +++++----
 4 files changed, 17 insertions(+), 11 deletions(-)
