Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 6F27067BCE
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 20:34:06 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k8TBs20T010812
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 05:54:02 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k8TAY2JK022831
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 05:34:03 -0500 (CDT)
Message-ID: <451CF6C0.7040701@freescale.com>
Date: Fri, 29 Sep 2006 18:34:40 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: paulus@samba.org, Kumar <galak@kernel.crashing.org>
Subject: [PATCH 0/9] Add support for QE and 8360EMDS board -v3
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

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
