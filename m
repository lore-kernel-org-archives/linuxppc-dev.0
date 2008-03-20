Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id D8E5BDDF0C
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 08:33:05 +1100 (EST)
Date: Thu, 20 Mar 2008 17:33:02 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: linuxppc-dev@ozlabs.org <linuxppc-dev@ozlabs.org>
Subject: DTS question
Message-ID: <20080320173302.7075a1d9@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The warp has an AD7414 chip hanging off the I2C bus. This chip can
raise an interrupt when it crosses a critical threshold.

This interrupt is tied to IRQ2 from the processor. What is the best
way to describe this interrupt in the DTS?

The warp.dts is available on request, but the one in the for-2.6.25
tree is relatively up to date.

Cheers,
   Sean
