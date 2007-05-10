Return-Path: <ajz@cambridgebroadband.com>
Received: from zambia.cambridgebroadband.com (ip-217-204-121-82.easynet.co.uk
	[217.204.121.82])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16CBCDDECE
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 May 2007 02:45:22 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by zambia.cambridgebroadband.com (8.12.8/8.12.8) with ESMTP id
	l4AGjIPg031612
	for <linuxppc-embedded@ozlabs.org>; Thu, 10 May 2007 17:45:18 +0100
Message-ID: <46434C1E.3020004@cambridgebroadband.com>
Date: Thu, 10 May 2007 17:45:18 +0100
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: 83xx: requesting external interrupts
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi list,

I'm trying to port a driver from 2.6.11 to 2.6.21 and I'm stuck on the following line:

	request_irq(MPC83xx_IRQ_EXT5, mpc832xemds_phy_interrupt, SA_SHIRQ, "pm5384", dev);

The first problem is that MPC83xx_IRQ_EXT5 is no longer defined.  If I hard code this to
what I think is the right value (i.e. 21) then request_irq fails on insmod.

I obviously need to do something different now that ARCH=powerpc, but I can't find any
examples of code which requests 83xx external interrupts.  Can anybody help?

TIA,

Alex
