Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 8888EDDFA1
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 23:27:10 +1000 (EST)
Received: by gxk14 with SMTP id 14so29012481gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Sep 2008 06:27:08 -0700 (PDT)
Date: Thu, 18 Sep 2008 09:26:09 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20080918132609.GA22217@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull the 'next' branch from my tree to pick up the first round of
commits for 2.6.28.  I have a few other changes to go, but these have been
out there for a while and I'd like to get them merged now.

Thanks,
josh

The following changes since commit 7713fef06517d216f96ee7c8ad750e72bc08d38f:
  Stephen Rothwell (1):
        powerpc: Remove include of linux/of_device.h from asm/of_device.h

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Ilya Yanok (1):
      powerpc/4xx: Necessary fixes to PCI for 4GB RAM size

Josh Boyer (9):
      powerpc/44x: Add PowerPC 44x simple platform support
      powerpc/44x: Migrate Bamboo support to ppc44x_simple
      powerpc/44x: Migrate Canyonlands support to ppc44x_simple
      powerpc/44x: Migrate Katmai support to ppc44x_simple
      powerpc/44x: Migrate Rainier support to ppc44x_simple
      powerpc/44x: Migrate Sequoia support to ppc44x_simple
      powerpc/44x: Migrate Taishan support to ppc44x_simple
      powerpc/44x: Add explicit support for AMCC Glacier
      powerpc/44x: Add explicit Yosemite support

Matthias Fuchs (1):
      powerpc/44x: Add hwmon support to Sequoia device tree

Tirumala R Marri (1):
      powerpc/44x: AMCC PPC460GT/EX PCI-E de-emphasis adjustment fix

 arch/powerpc/boot/dts/glacier.dts          |    2 +-
 arch/powerpc/boot/dts/sequoia.dts          |    9 +++
 arch/powerpc/boot/dts/yosemite.dts         |    2 +-
 arch/powerpc/platforms/44x/Kconfig         |   25 ++++++++
 arch/powerpc/platforms/44x/Makefile        |    8 +--
 arch/powerpc/platforms/44x/bamboo.c        |   62 --------------------
 arch/powerpc/platforms/44x/canyonlands.c   |   63 --------------------
 arch/powerpc/platforms/44x/katmai.c        |   62 --------------------
 arch/powerpc/platforms/44x/ppc44x_simple.c |   87 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/rainier.c       |   62 --------------------
 arch/powerpc/platforms/44x/sequoia.c       |   63 --------------------
 arch/powerpc/platforms/44x/taishan.c       |   72 -----------------------
 arch/powerpc/sysdev/ppc4xx_pci.c           |   23 ++++----
 13 files changed, 135 insertions(+), 405 deletions(-)
 delete mode 100644 arch/powerpc/platforms/44x/bamboo.c
 delete mode 100644 arch/powerpc/platforms/44x/canyonlands.c
 delete mode 100644 arch/powerpc/platforms/44x/katmai.c
 create mode 100644 arch/powerpc/platforms/44x/ppc44x_simple.c
 delete mode 100644 arch/powerpc/platforms/44x/rainier.c
 delete mode 100644 arch/powerpc/platforms/44x/sequoia.c
 delete mode 100644 arch/powerpc/platforms/44x/taishan.c
