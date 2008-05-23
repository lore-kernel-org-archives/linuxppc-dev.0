Return-Path: <renaud.barbier@ge.com>
Received: from ext-nj2ut-2.online-age.net (ext-nj2ut-2.online-age.net
	[64.14.54.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5B508DE1AD
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 00:09:31 +1000 (EST)
Received: from int-nj2ut-6.online-age.net (int-nj2ut-6.online-age.net
	[3.159.237.75])
	by ext-nj2ut-2.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id m4NE2Skg030063
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 10:02:28 -0400
Received: from alpmlip01.e2k.ad.ge.com (int-nj2ut-6.online-age.net
	[3.159.237.75])
	by int-nj2ut-6.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id m4NE2Stw012066
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 10:02:28 -0400
Received: from [3.26.68.208] (coniston.ramix-uk.cho.ge.com [3.26.68.208])
	by doyen.ramix-uk.cho.ge.com (Postfix) with ESMTP id EC9B9410F5
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 15:02:26 +0100 (BST)
Message-ID: <4836CE70.3030000@ge.com>
Date: Fri, 23 May 2008 15:02:24 +0100
From: Renaud Barbier <renaud.barbier@ge.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: 405EP PCI arbiter bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,
I noticed that on my  405EP board (made in-house), the PCI Arbiter bit 
is not set
in the CPC0_PCI register even though CPC0_PCI[PAE] bit 5 is set in the 
serial EEPROM.
Other registers (PLL,...) bits are set correctly and got their value 
from the IIC.

I check the value of I2C and CPC0_PCI[PAE] bits under U-boot and nothing 
in the code
seems to clear this register bit(CPC0_PCI[PAE]).

Is there any errata regarding these CPU I have missed or should I keep 
investigating
the hardware side?

thanks.
