Return-Path: <tharvan@inaccessnetworks.com>
Received: from inaccessnetworks.com (node3.inaccessnetworks.com
	[212.205.200.118]) by ozlabs.org (Postfix) with ESMTP id BF90E687F5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Nov 2005 22:30:33 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by inaccessnetworks.com (8.13.5/8.13.5) with ESMTP id jATBEin1001524
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Nov 2005 13:14:44 +0200
Date: Tue, 29 Nov 2005 13:14:42 +0200
To: linuxppc-embedded@ozlabs.org
Message-ID: <20051129111442.GB27630@inaccessnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Thomas Arvanitis <tharvan@inaccessnetworks.com>
Subject: spi on mpc82xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I was wondering what is the status for supporting spi devices with 2.6
on an mpc82xx device (I use an mpc8275). I checked and the kernel from
kernel.org does not include anything. Is there an spi bus
infrastructure (like i2c) coming any time soon, where one can add
support for specific chips, and then write a driver on top of that?
Or a plan for these things?

I found a patch for something like that, by Grant Likely, but I don't
know whether I should go that way.

I want to write a driver for controlling the micrel ks8995 ethernet
switch through spi. Should I just go for a self contained driver?

Thanks for you help,
-Thomas.
