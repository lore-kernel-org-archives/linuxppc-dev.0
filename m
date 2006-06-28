Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 0E00267B44
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 00:22:57 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k5SEXtnv001722
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 07:33:55 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5SEMrhr000608
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 09:22:55 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FD1@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Paul Mackerras'" <paulus@samba.org>
Subject: [PATCH 0/7] Add mpc8360epb and QE support to powerpc
Date: Wed, 28 Jun 2006 22:22:51 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches add support to MPC8360E MDS-PB board into powerpc arch.  It provides generic QE API called qe_lib.  Other QE device drivers should use this library.  It also includes an UCC gigabit Ethernet driver using qe_lib; mtd mapping file to use jffs/jffs2 filesystem.

--
Leo Li
Freescale Semiconductor
 
LeoLi@freescale.com 
