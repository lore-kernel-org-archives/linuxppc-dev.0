Return-Path: <Bruce_Leonard@selinc.com>
Received: from tesla.selinc.com (tesla.selinc.com [12.110.71.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "tesla.selinc.com", Issuer "RSA Data Security,
	Inc." (verified OK)) by ozlabs.org (Postfix) with ESMTP id 881B7DDD02
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Feb 2007 13:16:15 +1100 (EST)
In-Reply-To: <OF37CF163F.2ABC0002-ON8825728C.00068359-8825728C.00075898@selinc.com>
To: Bruce_Leonard@selinc.com
Subject: Re: MPC834x global timers question
MIME-Version: 1.0
Message-ID: <OFA2B855F5.8FEEC16C-ON8825728C.000C6AC9-8825728C.000C740E@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Fri, 23 Feb 2007 18:16:01 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Never mind, I answered my own question.  Sorry for the noise.

Bruce

linuxppc-embedded-bounces+brucle=selinc.com@ozlabs.org wrote on 02/23/2007 
05:20:14 PM:

> I know this isn't the right forum for this but I can't seem to find a 
> generic PPC mailing list.
> 
> I'm trying to get a global timer going on an MPC834x, and the way I 
learn 
> is to just play with HW, so I've got an Abatron BDI2K hooked up to my 
> processor so I can just manipulate registers without having to deal with 

> writing code.  However, I seem to be unable to modify certain registers 
in 
> the global timers with this set up and I don't understand why. 
> Specifically, if a register has a bit that's a '1' following a reset, I 
> can't change that bit to a '0'.  This is happening with the Global 
Timers 
> Reference Registers (GTRFR1 - 4) and the Global Timers Prescale 
Registers 
> (GTPSR1 - 4).  The reset state of the GTRFRs is 0xFFFF and I can't 
change 
> it to any other value.  The reset state of the GTPSRs is 0x3 and I can't 

> clear the 2 LSB.  I can change any other bits in the prescale registers, 

> but not the two which are a '1' at reset.
> 
> Has anyone else seen this behavior?
> 
> Bruce
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
