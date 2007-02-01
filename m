Return-Path: <sb@thebackend.de>
Received: from mail.thebackend.de (www.thebackend.de [217.20.114.244])
	by ozlabs.org (Postfix) with ESMTP id 4916CDDE30
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 19:21:35 +1100 (EST)
Received: from [192.168.178.26] (p5485D8AF.dip.t-dialin.net [84.133.216.175])
	by mail.thebackend.de (Postfix) with ESMTP id 8B2CB93D6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 08:44:11 +0100 (CET)
Mime-Version: 1.0 (Apple Message framework v752.3)
Message-Id: <A0BE90C9-AC7B-40AC-ACD2-E303B15CAF1A@thebackend.de>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linuxppc-embedded@ozlabs.org
From: =?ISO-8859-1?Q?Sebastian_Br=FCckner?= <sb@thebackend.de>
Subject: MV64360 ethernet controller
Date: Thu, 1 Feb 2007 08:58:48 +0100
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everyone,

I recently got a few Force/Motorola PowerPMC-280 PMC modules  
consisting mainly of a MPC7447 G4 an the Marvell MV64360 system  
controller. Since this a hobbyist project only I don't have  
Montavista Linux which seems to already support the board. Instead I  
ported the stock Linux kernel. Works quite well so far. The only  
thing I did not get to work is the integrated ethernet. The  
mv64360_eth driver loads fine and sees both ports. It does not get  
any interrupts for incoming packets (activity led blinks though).  
Only unplugging the cable generates an interrupt.

Since I do not have any documentation on the Marvell chip and the  
company does not answer my request I am quite lost.

The PHY interrupts are routed to one of the GPIO/interrupt pins. I  
did not find any code in the ethernet driver that would be able to  
use it though. Is it needed at all?

Any hint is appreciated!
Sebastian
