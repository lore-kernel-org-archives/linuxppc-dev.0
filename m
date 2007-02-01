Return-Path: <andrew@cesa.opbu.xerox.com>
Received: from fw7.opbu.xerox.com (fw7.opbu.xerox.com [192.65.17.10])
	by ozlabs.org (Postfix) with ESMTP id 10942DDDDB
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Feb 2007 11:22:16 +1100 (EST)
Received: from hermes.opbu.xerox.com (hermes.opbu.xerox.com [13.62.6.81])
	by fw7-6050.opbu.xerox.com with ESMTP id l110MEhK002236
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 16:22:14 -0800 (PST)
Received: from pogo.cesa.opbu.xerox.com (pogo.cesa.opbu.xerox.com
	[13.62.33.31])
	by hermes.opbu.xerox.com (8.13.7+Sun/8.13.4) with ESMTP id
	l110MCTg015650
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 16:22:12 -0800 (PST)
Received: from cesa.opbu.xerox.com (gto.cesa.opbu.xerox.com [13.62.136.98])
	by pogo.cesa.opbu.xerox.com (8.13.6+Sun/8.13.6) with ESMTP id
	l110MCan009105
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 16:22:12 -0800 (PST)
Message-Id: <200702010022.l110MCan009105@pogo.cesa.opbu.xerox.com>
To: linuxppc-dev@ozlabs.org
Subject: I don't understand #size-cells = <0>
Date: Wed, 31 Jan 2007 16:22:12 -0800
From: Andrew Klossner <andrew@cesa.opbu.xerox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm porting the kernel to an 8548-based board whose boot loader does
not provide a device tree, so I'm rolling my own.

Rev 0.5 of booting-without-of.txt says:

	"reg" properties are always a tuple of the type "address size"
	where the number of cells of address and size is specified by
	the bus #address-cells and #size-cells.

but in the examples, we see

		reg = <22000 1000>;
		#address-cells = <1>;
		#size-cells = <0>;

The number of cells of address is 1.  The number of cells of size is 0.
1+0=1, so how can the reg property have a tuple of size 2?

I saw Ben's mention last June of a "degenerate range", but I can't
find that term used anywhere else.

What are the real semantics of #size-cells = <0> ?

Thanks,
Andrew Klossner
