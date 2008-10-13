Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f14.google.com (mail-gx0-f14.google.com
	[209.85.217.14]) by ozlabs.org (Postfix) with ESMTP id DBF0FDE7F1
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 05:10:54 +1100 (EST)
Received: by gxk7 with SMTP id 7so4771188gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:10:53 -0700 (PDT)
Message-Id: <cover.1223921238.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Mon, 13 Oct 2008 14:07:18 -0400
Subject: [PATCH 0/5] Acadia support
To: linuxppc-dev@ozlabs.org
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updated patch set for the AMCC Acadia board.  As Arnd suggested, I implemented
the ppc40x_simple platform and simply add Acadia as the first supported board.

The patches are slightly reordered and the defconfig is updated as well.

josh

Josh Boyer (5):
  powerpc/40x: AMCC PowerPC 405EZ Acadia DTS
  powerpc/40x: Add AMCC PowerPC 405EZ to cputable
  powerpc/40x: Add PowerPC 40x simple platform support
  powerpc/40x: Add cuboot wrapper for Acadia board
  powerpc/40x: Add PowerPC 405EZ Acadia defconfig

 arch/powerpc/boot/Makefile                 |    4 +-
 arch/powerpc/boot/cuboot-acadia.c          |  174 ++++++
 arch/powerpc/boot/dts/acadia.dts           |  224 +++++++
 arch/powerpc/configs/40x/acadia_defconfig  |  921 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c             |   13 +
 arch/powerpc/platforms/40x/Kconfig         |   22 +
 arch/powerpc/platforms/40x/Makefile        |    1 +
 arch/powerpc/platforms/40x/ppc40x_simple.c |   80 +++
 8 files changed, 1438 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-acadia.c
 create mode 100644 arch/powerpc/boot/dts/acadia.dts
 create mode 100644 arch/powerpc/configs/40x/acadia_defconfig
 create mode 100644 arch/powerpc/platforms/40x/ppc40x_simple.c
