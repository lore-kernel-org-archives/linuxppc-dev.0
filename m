Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.233])
	by ozlabs.org (Postfix) with ESMTP id A10B1DE0B7
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 23:38:16 +1100 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so275687wra.1
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 05:38:14 -0700 (PDT)
Message-Id: <cover.1223642006.git.jwboyer@linux.vnet.ibm.com>
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Fri, 10 Oct 2008 08:33:26 -0400
Subject: [PATCH 0/5] AMCC PowerPC 405EZ Acadia eval board port
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

This is the latest set of Acadia patches I have.  If there are no
major objections to these, I intend to put them in my next branch
for 2.6.28

josh

Josh Boyer (5):
  powerpc/40x: AMCC PowerPC 405EZ Acadia DTS
  powerpc/40x: Add support for PowerPC 405EZ Acadia board
  powerpc/40x: Add AMCC PowerPC 405EZ to cputable
  powerpc/40x: Add cuboot wrapper for Acadia board
  powerpc/40x: Add PowerPC 405EZ Acadia defconfig

 arch/powerpc/boot/Makefile                |    4 +-
 arch/powerpc/boot/cuboot-acadia.c         |  174 ++++++
 arch/powerpc/boot/dts/acadia.dts          |  224 +++++++
 arch/powerpc/configs/40x/acadia_defconfig |  917 +++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c            |   13 +
 arch/powerpc/platforms/40x/Kconfig        |   14 +
 arch/powerpc/platforms/40x/Makefile       |    1 +
 arch/powerpc/platforms/40x/acadia.c       |   56 ++
 8 files changed, 1402 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-acadia.c
 create mode 100644 arch/powerpc/boot/dts/acadia.dts
 create mode 100644 arch/powerpc/configs/40x/acadia_defconfig
 create mode 100644 arch/powerpc/platforms/40x/acadia.c
