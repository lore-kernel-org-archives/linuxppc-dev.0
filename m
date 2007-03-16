Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 49F9DDDDF8
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:26:48 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l2GHQiAu025144
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:26:45 -0700 (MST)
Date: Fri, 16 Mar 2007 12:26:41 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 00/17] bootwrapper/cuImage patches
Message-ID: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patchset supersedes patches 2 and 14-17 of my previous (Mar. 13)
patchset. It depends on patches 11-13 of that patchset (in addition to
the patches that have been applied).  Patch 18 from that set (Add
linux,stdout-path to the dts files) should probably wait until u-boot has
been updated to handle a pre-existing /chosen node.

-Scott
