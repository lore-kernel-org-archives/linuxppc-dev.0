Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx020.isp.belgacom.be (outmx020.isp.belgacom.be
	[195.238.4.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 03498679E2
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 May 2006 20:30:58 +1000 (EST)
Received: from outmx020.isp.belgacom.be (localhost [127.0.0.1])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4MAUh7e008859
	for <linuxppc-embedded@ozlabs.org>; Mon, 22 May 2006 12:30:44 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx020.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k4MAUet6008818
	for <linuxppc-embedded@ozlabs.org>; Mon, 22 May 2006 12:30:41 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Preferred way to configure MTD physical mapping and partitioning
Date: Mon, 22 May 2006 12:32:14 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200605221232.14880.laurent.pinchart@tbox.biz>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everybody,

while browsing the kernel sources to find out how other boards configure MTD 
physical mapping and partitioning, I noticed that a couple of different 
approaches were possible:

- adding a board specific "driver" in drivers/mtd/maps and handle all mapping 
manually
- adding board specific MTD configuration in arch/ppc/platforms with calls to 
physmap_set_partitions() and physmap_configure()
- adding board specific MTD configuration in arch/ppc/platforms with a call to 
physmap_set_partitions(), and using the CONFIG_MTD_PHYSMAP option with 
physical mapping values provided in the kernel configuration.

Could anyone comment on the preferred approach ?

Best regards,

Laurent Pinchart
