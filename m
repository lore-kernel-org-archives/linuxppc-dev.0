Return-Path: <skepper@chara.vm.bytemark.co.uk>
Received: from chara.vm.bytemark.co.uk (chara.vm.bytemark.co.uk [80.68.89.253])
	by ozlabs.org (Postfix) with ESMTP id A1115DDFB1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 20:07:33 +1000 (EST)
Received: from skepper (helo=localhost)
	by chara.vm.bytemark.co.uk with local-esmtp (Exim 3.36 #1 (Debian))
	id 1KdMbh-0006SJ-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 10 Sep 2008 11:07:29 +0100
Date: Wed, 10 Sep 2008 11:07:29 +0100 (BST)
From: Chris Skepper <skepper@ukf.net>
To: linuxppc-embedded@ozlabs.org
Subject: Not probing devices on PowerPC MPC8247 and kernel 2.6.26
Message-ID: <Pine.LNX.4.62.0809101058580.24139@chara.vm.bytemark.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: Chris Skepper <skepper@chara.vm.bytemark.co.uk>
Reply-To: skepper@ukf.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I have an MPC8247 based board.  I can get the SMC1 console working, but 
the other SCCx serial ports and the FCC1 ethernet doesn't work.

It appears that a part of the problem is that the probe methods are not 
called.  The "match" table stuff all looks fine and the serial ports and 
ethernet are defined in the .dts file. The module init function is called, 
but the probe methods are not reached. It seems driver_register gets 
called, so why doesn't something call probe?

Is there likely to be some problem with the bus setup?

Cheers,

Chris.
