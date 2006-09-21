Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 58FCB67BFA
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 22:17:00 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k8LCGxRE005699
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 05:16:59 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8LCGvQs003411
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 07:16:58 -0500 (CDT)
Message-ID: <451282DA.2080508@freescale.com>
Date: Thu, 21 Sep 2006 20:17:30 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/11] Add support for QE and 8360EMDS board
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The series of patches add generic QE infrastructure called 
qe_lib, and MPC8360EMDS board support.  Qe_lib is used by
QE device drivers such as ucc_geth driver.

This version updates QE interrupt controller to use new irq
mapping mechanism ,addresses all the comments received with
last submission and includes some style fixes. 

- Leo
