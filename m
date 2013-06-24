Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 901AF2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 08:02:50 +1000 (EST)
Date: Mon, 24 Jun 2013 17:02:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git for-3.10
Message-ID: <20130624220237.GA24585@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a regression that causes 83xx to oops on boot if a
non-express PCI bus is present.  It is the same patch as the last pull
request, but with the changelog reworded to be clearer that this is a
regression.

The following changes since commit 17858ca65eef148d335ffd4cfc09228a1c1cbfb5:

  Merge tag 'please-pull-fixia64' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux (2013-06-18 06:29:19 -1000)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git for-3.10

for you to fetch changes up to b37e161388ac3980d5dfb73050e85874b84253eb:

  powerpc/pci: Fix boot panic on mpc83xx (regression) (2013-06-24 16:54:09 -0500)

----------------------------------------------------------------
Rojhalat Ibrahim (1):
      powerpc/pci: Fix boot panic on mpc83xx (regression)

 arch/powerpc/sysdev/fsl_pci.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)
