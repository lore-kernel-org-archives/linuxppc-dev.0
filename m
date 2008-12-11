Return-Path: <jwboyer@gmail.com>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.181])
	by ozlabs.org (Postfix) with ESMTP id 9F98FDDF85
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 02:17:07 +1100 (EST)
Received: by ik-out-1112.google.com with SMTP id c28so447306ika.1
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 07:17:05 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 11 Dec 2008 10:09:18 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20081211150918.GA16533@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Please pull the 'next' branch of the 4xx tree to pick up some initial
commits for 2.6.29.

There are a large number of patches from Ben for some MMU rework that
will effect 4xx, but I think most of those are going in either through
you directly, or through Kumar.  I have a couple of other commits I 
need to test out, so expect a future pull request as well.

josh

The following changes since commit 361425fc32422c9716fc69e52455b7d44fc02c18:
  Haiying Wang (1):
        powerpc/85xx: Create dts for each core in CAMP mode for MPC8572DS

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Benjamin Herrenschmidt (1):
      powerpc/4xx: Add support for ISA holes on 4xx PCI/X/E

Hollis Blanchard (1):
      powerpc/kvm: update KVM config options in ppc44x_defconfig

Stefan Roese (1):
      powerpc/4xx: Add L2 cache node to AMCC Canyonlands dts file

Stephen Rothwell (1):
      powerpc/44x: update ppc44x_defconfig

 arch/powerpc/boot/dts/bamboo.dts      |    3 +-
 arch/powerpc/boot/dts/canyonlands.dts |   14 ++
 arch/powerpc/configs/ppc44x_defconfig |   12 +-
 arch/powerpc/sysdev/ppc4xx_pci.c      |  306 ++++++++++++++++++++++-----------
 4 files changed, 230 insertions(+), 105 deletions(-)
