Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4BFC42C02ED
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jun 2013 06:15:07 +1000 (EST)
Date: Tue, 18 Jun 2013 15:14:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: <galak@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git for-3.10
Message-ID: <20130618201452.GA5429@home.buserror.net>
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
non-express PCI bus is present.

The following changes since commit 17858ca65eef148d335ffd4cfc09228a1c1cbfb5:

  Merge tag 'please-pull-fixia64' of git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux (2013-06-18 06:29:19 -1000)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git for-3.10

for you to fetch changes up to 2383ea94854bcf5a0df3c6803b980868cef95418:

  powerpc/pci: Fix setup of Freescale PCI / PCIe controllers (2013-06-18 14:44:57 -0500)

----------------------------------------------------------------
Rojhalat Ibrahim (1):
      powerpc/pci: Fix setup of Freescale PCI / PCIe controllers

 arch/powerpc/sysdev/fsl_pci.c |   24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)
