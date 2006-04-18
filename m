Return-Path: <laurent.pinchart@tbox.biz>
Received: from outmx013.isp.belgacom.be (outmx013.isp.belgacom.be
	[195.238.5.64])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E601167A39
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Apr 2006 23:08:48 +1000 (EST)
Received: from outmx013.isp.belgacom.be (localhost [127.0.0.1])
	by outmx013.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k3ID8akl023441
	for <linuxppc-embedded@ozlabs.org>; Tue, 18 Apr 2006 15:08:38 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
Received: from servernt.technotrade (49.198-78-194.adsl-fix.skynet.be
	[194.78.198.49])
	by outmx013.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k3ID8XDk023389
	for <linuxppc-embedded@ozlabs.org>; Tue, 18 Apr 2006 15:08:35 +0200
	(envelope-from <laurent.pinchart@tbox.biz>)
From: Laurent Pinchart <laurent.pinchart@tbox.biz>
To: linuxppc-embedded@ozlabs.org
Subject: New fs_enet driver : filling platform_data
Date: Tue, 18 Apr 2006 15:09:38 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200604181509.38713.laurent.pinchart@tbox.biz>
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

I'm trying to use the new fs_enet FCC ethernet driver (drivers/net/fs_enet) 
with an Embedded Planet EP8284 board (LXT971A phy).

I don't know how/where to fill the platform_data structure that the 
mii-bitbang driver uses. Could anyone give me some help, or point me to a 
sample implementation for a similar platform ?

Best regards,

Laurent Pinchart
