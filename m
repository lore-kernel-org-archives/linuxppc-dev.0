Return-Path: <kylo@kylo.net>
Received: from cia.veriwave.com (unknown [198.107.59.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C850267A64
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 11:29:20 +1100 (EST)
Received: from [192.168.100.42] (ion13.veriwave.com [192.168.100.42])
	(authenticated bits=0)
	by cia.veriwave.com (8.12.8/8.12.8) with ESMTP id j2901H30032027
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <linuxppc-embedded@ozlabs.org>; Tue, 8 Mar 2005 16:01:17 -0800
Message-ID: <422E3CCD.4020204@kylo.net>
Date: Tue, 08 Mar 2005 16:01:17 -0800
From: Kylo Ginsberg <kylo@kylo.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Recommended kernel version/tree for use with MPC8555E?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I've just started working on s/w for an 8555E-based board.  On the 8555E 
I will be using the TSECs (Gigabit ethernet interfaces), DMA engines, 
the security engine, UARTs, DDR and Local Bus controllers and that's 
about it.

Right now I've got an MPC8560ADS eval board to test against.  This board 
came with a 2.4.26-based kernel; it boots ok and runs the basic apps 
fine, however I haven't yet had an opportunity to exercise the wide 
array of functionality on the chip, so I don't know what gotchas or 
porting difficulties I might meet ahead.

Based on that, what kernel version/tree would you recommend?  Should I 
stick with what I've got, move to a ppc-specific 2.4 tree, or jump to 
2.6.x?  Are there performance/features vs. stability tradeoffs I should 
be warned of?

Thanks in advance for any thoughts you may have.

Kylo
