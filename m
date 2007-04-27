Return-Path: <ckrinke@istor.com>
Received: from stork.inside.istor.com (stork.istor.com [12.170.66.34])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB8D0DDF89
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 02:55:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: How do external irq's get mapped?
Date: Fri, 27 Apr 2007 09:55:37 -0700
Message-ID: <9F3F0A752CAEBE4FA7E906CC2FBFF57C06A1EE@MERCURY.inside.istor.com>
In-Reply-To: <1177688490.8797.11.camel@ld0161-tx32>
From: "Charles Krinke" <ckrinke@istor.com>
To: "Jon Loeliger" <jdl@freescale.com>
Cc: Randy Brown <rbrown@istor.com>, Chris Carlson <ccarlson@istor.com>,
	Kevin Smith <ksmith@istor.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Let me try a more simplified IRQ question a different way by only
referring to the 8541.

There are 12 external interrupt sources, irq[0..11] and as I understand
it, they all go through one vector, ExternalInput set in
head_fsl_booke.S and this vector resolves to "do_IRQ()", which I believe
is in arch/powerpc/kernel/irq.c (not arch/ppc/kernel/...).

I am striving to understand how mapping of these external pins
irq[0..11] gets to IRQ numbers as shown with "cat /proc/interrupts".

Could someone point me at some references I can read to understand this
nuance of the 8541 in a linux-2.6.17.11 kernel, please.

Charles
