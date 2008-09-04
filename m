Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id C8AD84774B
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 01:45:20 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so393anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 08:45:19 -0700 (PDT)
Date: Thu, 4 Sep 2008 11:44:31 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] [PATCH 0/4] Initial PowerPC 405EZ Acadia support
Message-ID: <20080904154431.GA2579@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Josh Boyer <jwboyer@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds initial support for the AMCC PowerPC 405EZ board.  Mostly
sending these out for comments as I clean them up.  The cuboot wrapper
needs particular cleaning, as the clocking function has a ridiculous
number of variables.  But hey, it works.  These patches depend on the
EMAC series I sent out earlier today.

Comments welcome.

josh

Josh Boyer (4):
  powerpc/40x: AMCC PowerPC 405EZ Acadia DTS
  powerpc/40x: Add support for PowerPC 405EZ Acadia board
  powerpc/40x: Add cuboot wrapper for Acadia board
  powerpc/40x: Add PowerPC 405EZ Acadia defconfig

 arch/powerpc/boot/Makefile                |    4 +-
 arch/powerpc/boot/cuboot-acadia.c         |  198 +++++++
 arch/powerpc/boot/dts/acadia.dts          |  224 +++++++
 arch/powerpc/configs/40x/acadia_defconfig |  917 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/40x/Kconfig        |   14 +
 arch/powerpc/platforms/40x/Makefile       |    1 +
 arch/powerpc/platforms/40x/acadia.c       |   56 ++
 7 files changed, 1413 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-acadia.c
 create mode 100644 arch/powerpc/boot/dts/acadia.dts
 create mode 100644 arch/powerpc/configs/40x/acadia_defconfig
 create mode 100644 arch/powerpc/platforms/40x/acadia.c
