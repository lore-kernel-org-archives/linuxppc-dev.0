Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23A85B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Dec 2010 00:24:00 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e31.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB3DAGST032025
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 06:10:16 -0700
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id oB3DNhfS102812
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 06:23:43 -0700
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oB3DNhXK017564
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Dec 2010 06:23:43 -0700
Date: Fri, 3 Dec 2010 08:22:55 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20101203132255.GB4489@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben

Some 4xx power management patches from Victor.  I would have liked to
include the PCI-e and Canyonlands USB phy fix patches as well, but they
still need rework.  I might include those in a later pull request if
they show up relatively soon.

josh

The following changes since commit 46f5221049bb46b0188aad6b6dfab5dbc778be22:

  powerpc: Remove second definition of STACK_FRAME_OVERHEAD (2010-11-29 15:48:23 +1100)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Victor Gallardo (3):
      powerpc/4xx: Add suspend and idle support
      powerpc/4xx: Add Kilauea suspend and idle support
      powerpc/4xx: Add Canyonlands suspend and idle support

 Documentation/powerpc/dts-bindings/4xx/cpm.txt |   52 ++++
 arch/powerpc/Kconfig                           |   13 +-
 arch/powerpc/boot/dts/canyonlands.dts          |   31 +--
 arch/powerpc/boot/dts/kilauea.dts              |    9 +
 arch/powerpc/configs/40x/kilauea_defconfig     |    5 +
 arch/powerpc/configs/44x/canyonlands_defconfig |    3 +
 arch/powerpc/platforms/44x/Makefile            |    5 +-
 arch/powerpc/sysdev/Makefile                   |    1 +
 arch/powerpc/sysdev/ppc4xx_cpm.c               |  346 ++++++++++++++++++++++++
 9 files changed, 439 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/4xx/cpm.txt
 create mode 100644 arch/powerpc/sysdev/ppc4xx_cpm.c
