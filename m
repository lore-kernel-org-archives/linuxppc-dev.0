Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx022.isp.belgacom.be (outmx022.isp.belgacom.be
	[195.238.4.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F70B67BB2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 19:23:55 +1000 (EST)
Received: from outmx022.isp.belgacom.be (localhost [127.0.0.1])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k5E9NgPn008235
	for <linuxppc-embedded@ozlabs.org>; Wed, 14 Jun 2006 11:23:42 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx022.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k5E9NUBQ008082
	for <linuxppc-embedded@ozlabs.org>; Wed, 14 Jun 2006 11:23:30 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: MMC/SD driver using SPI interface on MPC8248
Date: Wed, 14 Jun 2006 11:25:08 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200606141125.08298.laurent.pinchart@tbox.biz>
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

I'm looking for an MMC/SD driver using the MPC8248 SPI interface. Does anyone 
know if such a driver exist, or if some code has already been written ?

If no such project exists, could anyone outline the basic architecture of such 
a driver ? As recent Linux kernels include an SPI class, I suppose I should 
write a generic MMC/SD-SPI driver which would work with any SPI controller, 
and write an SPI driver for the MPC8248 (which seem to have a similar 
interface to the already supported MPC83xx). How should the generic 
MMC/SD-SPI driver be mapped to specific SPI ports ?

Best regards,

Laurent Pinchart
