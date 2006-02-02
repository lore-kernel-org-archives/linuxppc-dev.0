Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx010.isp.belgacom.be (outmx010.isp.belgacom.be
	[195.238.5.233])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 450F968A46
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Feb 2006 00:58:39 +1100 (EST)
Received: from outmx010.isp.belgacom.be (localhost [127.0.0.1])
	by outmx010.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k12DwP8c029343
	for <linuxppc-embedded@ozlabs.org>; Thu, 2 Feb 2006 14:58:26 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx010.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k12DwOxg029330
	for <linuxppc-embedded@ozlabs.org>; Thu, 2 Feb 2006 14:58:24 +0100
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: Accessing the CPM2 on an MPC82xx : CPM_MAP_ADDR or cpm2_immr ?
Date: Thu, 2 Feb 2006 14:58:26 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200602021458.26623.laurent.pinchart@tbox.biz>
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

I noticed that the CPM2 module is accessed both through CPM_MAP_ADDR (physical 
address) and cpm2_immr (ioremap()ed address). For instance, the fec_enet 
driver configures the IO ports using (cpm2_map_t*)CPM_MAP_ADDR.

What's the correct way to access the CPM2 module ? Does ioremap() map 
CPM_MAP_ADDR to itself so that both ways are correct ?

Laurent Pinchart
