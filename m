Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D462E67B22
	for <linuxppc-dev@ozlabs.org>; Sun,  1 Oct 2006 09:32:19 +1000 (EST)
Date: Sat, 30 Sep 2006 18:31:57 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/15] Add support for QE and 8360EMDS board
Message-Id: <20060930183157.01d32be1.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm resending Leo Li's 8360 patches. This series applies cleanly to the latest powerpc git tree, includes Leo's latest, removes typedefs, and converts some uint types to u32.

There is a problem with ucc_geth that is introduced with the platform_device to of_device conversion. This can (and will) be addressed during the bugfix stage.

Kim

---

The series of patches add generic QE infrastructure called
qe_lib, and MPC8360EMDS board support.  Qe_lib is used by
QE device drivers such as ucc_geth driver.

This version updates QE interrupt controller to use new irq
mapping mechanism, addresses all the comments received with
last submission and includes some style fixes.

v2: Change to use device tree for BCSR and MURAM;
Remove I/O port interrupt handling code as it is not generic
enough.

v3: Address comments from Kumar;  Update definition of several
device tree nodes;  Copyright style change.

- Leo
