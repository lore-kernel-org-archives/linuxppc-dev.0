Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx005.isp.belgacom.be (outmx005.isp.belgacom.be
	[195.238.4.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 61BE467B22
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Sep 2006 19:35:46 +1000 (EST)
Received: from outmx005.isp.belgacom.be (localhost [127.0.0.1])
	by outmx005.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k8D9ZelP011023
	for <linuxppc-embedded@ozlabs.org>; Wed, 13 Sep 2006 11:35:40 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx005.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k8D9Zbof010999
	for <linuxppc-embedded@ozlabs.org>; Wed, 13 Sep 2006 11:35:37 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: JTAG Flash programmer for MPC8248
Date: Wed, 13 Sep 2006 11:38:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200609131138.45308.laurent.pinchart@tbox.biz>
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

I'm looking for a solution to program flash memory on a MPC8248 board for 
production.

I remember hearing about a JTAG flash programmer that used boundary scan to 
control the flash signals, but can't find any reference to it anymore.

I know the BDI2000 is able to program the target flash memory, but I'm looking 
for a less expensive solution (I don't need debugging capabilities, just a 
plain flash programmer).

Any help will be appreciated.

Laurent Pinchart
