Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 6C596DDE31
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 12:20:29 +1100 (EST)
Received: from hopper.selinc.com (hopper.selinc.com [12.110.71.10])
	by tesla.selinc.com (8.12.11.20060308/8.12.11) with ESMTP id
	l1O1KPAW012332
	for <linuxppc-embedded@ozlabs.org>; Fri, 23 Feb 2007 17:20:25 -0800
To: linuxppc-embedded@ozlabs.org
Subject: MPC834x global timers question
MIME-Version: 1.0
Message-ID: <OF37CF163F.2ABC0002-ON8825728C.00068359-8825728C.00075898@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Fri, 23 Feb 2007 17:20:14 -0800
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I know this isn't the right forum for this but I can't seem to find a 
generic PPC mailing list.

I'm trying to get a global timer going on an MPC834x, and the way I learn 
is to just play with HW, so I've got an Abatron BDI2K hooked up to my 
processor so I can just manipulate registers without having to deal with 
writing code.  However, I seem to be unable to modify certain registers in 
the global timers with this set up and I don't understand why. 
Specifically, if a register has a bit that's a '1' following a reset, I 
can't change that bit to a '0'.  This is happening with the Global Timers 
Reference Registers (GTRFR1 - 4) and the Global Timers Prescale Registers 
(GTPSR1 - 4).  The reset state of the GTRFRs is 0xFFFF and I can't change 
it to any other value.  The reset state of the GTPSRs is 0x3 and I can't 
clear the 2 LSB.  I can change any other bits in the prescale registers, 
but not the two which are a '1' at reset.

Has anyone else seen this behavior?

Bruce
