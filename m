Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BDC60DDE26
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 01:50:38 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6AFoXZ9001464
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 08:50:34 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6AFoWXj010517
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:50:33 -0500 (CDT)
Subject: [patch 0/6] Unify the PCI/PCI Express support  for 83xx/85xx/86xx
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1184082619.20129.171.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 10 Jul 2007 23:50:20 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This series of patches do:

(1) unify the PCI/PCI express support
for 83xx/85xx/86xx.


(2) Add basic PCI Express support for mpc8548 Rev 2.0 
board.

(3) Add basic PCI support for mpc8568mds board.

The patches have been tested on 8548 rev2.0 with Arcadia 3.1 
board, mpc8568mds board and 8641HPCN board.

Some of them have been in the tree on opensource.freescale.com.
I regenerated them based on my previous patches and comments. 
The baseline is Kumar's current tree for paulus.

The VIA support on CDS board and PCI/E support for 
8544DS board will be in next series of patches :-).
