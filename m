Return-Path: <sbajaj@tsi-telsys.com>
Received: from exchange.tsi-telsys.com (unknown [205.230.130.11])
	by ozlabs.org (Postfix) with ESMTP id 5E2E667A67
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 02:02:54 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 18 Apr 2005 12:02:52 -0400
Message-ID: <0007F077BB3476449151699150E8FEA20592C8@exchange.tsi-telsys.com>
From: "Sanjay Bajaj" <sbajaj@tsi-telsys.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Unable to capture device interrupts on ppc440gx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In the device driver open function, I call request_irq() to register my =
interrupt handler function to a specified IRQ number. It succeeds. But =
when I enable the interrupt (and we can detect the hardware line is =
active) on the hardware, the interrupt handler in NOT invoked. Is there =
something I am missing? Any help or pointers are appreciated.

Sanjay
