Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5EE7B2C0091
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2012 23:39:55 +1000 (EST)
Date: Fri, 3 Aug 2012 08:39:38 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <alpine.LFD.2.00.1208030838490.4148@right.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

Weekly bug fix pull request.

- k

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

for you to fetch changes up to c9f11c30374329a0d2a88cf05281ca49d8eca9ab:

  powerpc/fsl-pci: Only scan PCI bus if configured as a host (2012-08-03 08:25:52 -0500)

----------------------------------------------------------------
Jia Hongtao (1):
      powerpc/fsl-pci: Only scan PCI bus if configured as a host

 arch/powerpc/sysdev/fsl_pci.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)
