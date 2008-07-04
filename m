Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id 022F3DDF36
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 03:22:46 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so777714pyg.27
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Jul 2008 10:22:44 -0700 (PDT)
Date: Fri, 4 Jul 2008 11:22:40 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: jwboyer@gmail.com, linuxppc-dev@ozlabs.org
Subject: Please pull linux-2.6-virtex.git
Message-ID: <20080704172240.GE17062@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Josh,

Here are the bulk of the Xilinx 440 support patches.  Please pull
into your next branch.

Thanks,
g.

The following changes since commit f3e909c2750eb20536bacacc867dc9047b70546a:
  Michael Neuling (1):
        powerpc: Update for VSX core file and ptrace

are available in the git repository at:

  git://git.secretlab.ca/git/linux-2.6-virtex virtex-for-2.6.27

Grant Likely (2):
      powerpc/bootwrapper: Add documentation of boot wrapper targets
      powerpc/bootwrapper: add missing bit of simpleImage target

John Linn (5):
      powerpc/virtex: add dts file for ML507 reference design
      powerpc/virtex: Fix booting of Xilinx FPGAs with 16550 for 405 and 440
      powerpc/virtex: add Xilinx Virtex 5 ppc440 platform support
      powerpc/virtex: add Xilinx 440 cpu to the cputable
      powerpc/virtex: add defconfig for virtex 5 platforms

 Documentation/powerpc/bootwrapper.txt      |  141 ++++
 arch/powerpc/Makefile                      |   15 +-
 arch/powerpc/boot/Makefile                 |    2 +-
 arch/powerpc/boot/dts/virtex440-ml507.dts  |  238 ++++++
 arch/powerpc/boot/simpleboot.c             |    6 +
 arch/powerpc/boot/virtex.c                 |  100 +++
 arch/powerpc/boot/wrapper                  |   10 +-
 arch/powerpc/configs/44x/virtex5_defconfig | 1107 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c             |   10 +
 arch/powerpc/platforms/44x/Kconfig         |   26 +
 arch/powerpc/platforms/44x/Makefile        |    1 +
 arch/powerpc/platforms/44x/virtex.c        |   60 ++
 12 files changed, 1713 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/powerpc/bootwrapper.txt
 create mode 100644 arch/powerpc/boot/dts/virtex440-ml507.dts
 create mode 100644 arch/powerpc/boot/virtex.c
 create mode 100644 arch/powerpc/configs/44x/virtex5_defconfig
 create mode 100644 arch/powerpc/platforms/44x/virtex.c
