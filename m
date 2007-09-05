Return-Path: <rwoodworth@securics.com>
Received: from securics.com (mail.securics.com [128.198.58.14])
	by ozlabs.org (Postfix) with ESMTP id 5DF00DDED4
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 04:42:30 +1000 (EST)
Received: from [192.168.0.38] (unknown [192.168.0.38])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by securics.com (Postfix) with ESMTP id C4E11B8C0B8
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Sep 2007 12:42:28 -0600 (MDT)
Subject: Xilinx FX60
From: Robert Woodworth <rwoodworth@securics.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 05 Sep 2007 12:42:28 -0600
Message-Id: <1189017748.6185.49.camel@PisteOff>
Mime-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

After achieving complete success with my Linux kernel on the ML403, I've
now started to build a kernel for my real target board with a
Virtex4-FX60 (dual PPC cores)

Has anyone built a kernel for a dual core PPC Virtex?  I have found very
little docs on how to architect software for the dual-core PPC's.  
Will SMP Linux work on this platform?  What would the bus setup be?



My kernel is partially booting, some of the time... I'm mystified by the
situation.  One time, I get all the happy boot messages through the
UARTLite port, then the next reboot it stops at "Now booting the kernel"
I'm only getting about 10% successful boots......


My EDK setup is as follows;  I've disconnected the second PPC from the
PLB to have a single PPC system, 32MB DDR on PLB, TEMAC on PLB, UARTLite
on OPB.
