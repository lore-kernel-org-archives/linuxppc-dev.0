Return-Path: <michael.firth@bt.com>
Received: from smtp2.smtp.bt.com (smtp2.smtp.bt.com [217.32.164.150])
	by ozlabs.org (Postfix) with ESMTP id 3E859DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Dec 2007 20:54:27 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Maximum ioremap size for ppc arch?
Date: Mon, 3 Dec 2007 09:22:06 -0000
Message-ID: <36D7B34A3A79F84F82FA0C154F299F2505FE26D2@E03MVX1-UKDY.domain1.systemhost.net>
From: <michael.firth@bt.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I'm trying to get am MPC834x system running that has 256MBytes of NOR
flash connected.

The physmap flash driver is failing to ioremap() that amount of space,
while on a similar system with 128Mbytes of flash, there are no
problems.

Is this a known limitation of ioremap() on the ppc architecture, or
specifically the MPC834x family, and is there any (hopefully easy) way
to increase this limit?

Thanks

Michael
