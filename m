Return-Path: <jamuelle@ee.ethz.ch>
Received: from smtp.ee.ethz.ch (smtp.ee.ethz.ch [129.132.2.219])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2455ADDD04
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 Dec 2008 07:18:43 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by smtp.ee.ethz.ch (Postfix) with ESMTP id 751EAD934F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Dec 2008 21:08:18 +0100 (MET)
Received: from smtp.ee.ethz.ch ([127.0.0.1])
	by localhost (.ee.ethz.ch [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id psYvn2nlQ8e1 for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Dec 2008 21:08:18 +0100 (MET)
Received: from [192.168.0.36] (dyn.144-85-219-087.dsl.vtx.ch [144.85.219.87])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested) (Authenticated sender: jamuelle)
	by smtp.ee.ethz.ch (Postfix) with ESMTP id 385DCD9333
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Dec 2008 21:08:18 +0100 (MET)
Message-ID: <493ADC3B.2040505@ee.ethz.ch>
Date: Sat, 06 Dec 2008 21:10:35 +0100
From: =?ISO-8859-15?Q?Jan_M=FCller?= <jamuelle@ee.ethz.ch>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: XUPV2P update to kernel 2.6 fails
Content-Type: text/plain; charset=ISO-8859-15
Reply-To: jamuelle@ee.ethz.ch
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I was wondering if anyone got the XUPV2P board successfully up and
running with a recent 2.6 kernel?

I didn't succeed. I tried the newest kernel from xilinx git (2.6.27) and
also an older one, 2.6.22 (also from xilinx git). For the newer I used
the "device-tree" as bsp. For the 2.6.22 I just copied over the
xparameters_ml300.h file.

In both cases no output at all was observable at the uart. Not even a
single sign from the uart at any time...

Strange is, the same download.bit file is working with a 2.4 kernel.
Could it be a kernel .config issue?

But can this really be a software/kernel issue? For the 2.4 kernel there
was an output from the "bootloader"  (some addresses and the
"Loading..." information) even for wrong configured kernels...

On this list I was reading something about setting the uart clockfreq
correctly in the .dts (it was not set at all, I have to stick with EDK
9.1). But this didn't help for me.

To boot the FPGA I have to use an ace file on a cf-disc. For this I use
the download.bit file together with the simpleImage.virtex405-XUPV2P.elf
(on 2.6.27) or zImage (on 2.6.22)...

Any suggestions on this? Thanks a lot!

Regards,
Jan
