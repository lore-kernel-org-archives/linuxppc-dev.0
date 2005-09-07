Return-Path: <susheel.nuguru@mitron.fi>
Received: from mitron.mitron.fi (mail.mitron.fi [82.116.252.3])
	by ozlabs.org (Postfix) with ESMTP id 1DC79681DF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Sep 2005 21:11:49 +1000 (EST)
From: Nuguru Susheel <susheel.nuguru@mitron.fi>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 07 Sep 2005 14:14:25 +0000
Message-Id: <1126102465.14131.16.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: newbie question : how to register for a new interrupt
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

   I have written an service routine for handling the GPIO_WAKEUP
interrupt PSC2_4 pin (MPC5200 Core), but I donno how to register this
routine into the kernel. 

I have connected an external circuit which generates interrupts to this
PSC2_4 pin, but I believe the Core doesnt know what to do when this
interrupt is generated without registering this routine ...

Help/Suggestions/Redirections please .......


--Cheers 
   nSr
