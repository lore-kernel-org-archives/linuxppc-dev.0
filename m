Return-Path: <jwboyer@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.235])
	by ozlabs.org (Postfix) with ESMTP id 94272DDDE3
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 00:15:38 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id s6so1194290wxc.15
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 06:15:36 -0700 (PDT)
Date: Mon, 20 Oct 2008 09:14:02 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Please pull 'next' branch of 4xx tree
Message-ID: <20081020131402.GA2300@yoda.jdub.homelinux.org>
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

Hi Ben,

Please pull the 'next' branch of the 4xx tree to pick up what should be
most of the remaining changes for 2.6.28.  Defconfig updates will come
after -rc1.

josh

The following changes since commit 6dc6472581f693b5fc95aebedf67b4960fb85cf0:
  Benjamin Herrenschmidt (1):
        Merge commit 'origin'

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Josh Boyer (5):
      powerpc/40x: AMCC PowerPC 405EZ Acadia DTS
      powerpc/40x: Add AMCC PowerPC 405EZ to cputable
      powerpc/40x: Add PowerPC 40x simple platform support
      powerpc/40x: Add cuboot wrapper for Acadia board
      powerpc/40x: Add PowerPC 405EZ Acadia defconfig

Niklaus Giger (1):
      powerpc/40x: Add support for Netstal HCU4 board

Steven A. Falco (1):
      powerpc/4xx: Add PowerPC 4xx GPIO driver

 arch/powerpc/boot/Makefile                 |    4 +-
 arch/powerpc/boot/cuboot-acadia.c          |  174 ++++++
 arch/powerpc/boot/dts/acadia.dts           |  224 +++++++
 arch/powerpc/boot/dts/hcu4.dts             |  168 +++++
 arch/powerpc/configs/40x/acadia_defconfig  |  921 +++++++++++++++++++++++++++
 arch/powerpc/configs/40x/hcu4_defconfig    |  929 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c             |   13 +
 arch/powerpc/platforms/40x/Kconfig         |   38 ++
 arch/powerpc/platforms/40x/Makefile        |    2 +
 arch/powerpc/platforms/40x/hcu4.c          |   61 ++
 arch/powerpc/platforms/40x/ppc40x_simple.c |   80 +++
 arch/powerpc/platforms/44x/Kconfig         |    8 +
 arch/powerpc/sysdev/Makefile               |    1 +
 arch/powerpc/sysdev/ppc4xx_gpio.c          |  217 +++++++
 14 files changed, 2839 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-acadia.c
 create mode 100644 arch/powerpc/boot/dts/acadia.dts
 create mode 100644 arch/powerpc/boot/dts/hcu4.dts
 create mode 100644 arch/powerpc/configs/40x/acadia_defconfig
 create mode 100644 arch/powerpc/configs/40x/hcu4_defconfig
 create mode 100644 arch/powerpc/platforms/40x/hcu4.c
 create mode 100644 arch/powerpc/platforms/40x/ppc40x_simple.c
 create mode 100644 arch/powerpc/sysdev/ppc4xx_gpio.c
