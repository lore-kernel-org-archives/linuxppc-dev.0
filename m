Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B77E267B56
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 18:17:58 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k8S8Hugg012114
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 01:17:56 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k8S8HrmU015987
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Sep 2006 03:17:55 -0500 (CDT)
Message-ID: <451B8553.30107@freescale.com>
Date: Thu, 28 Sep 2006 16:18:27 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH 0/12] Add support for QE and 8360EMDS board -v2
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

v2 change: Change to use device tree for BCSR and MURAM;
Remove I/O port interrupt handling code as it is not generic
enough.

- Leo
