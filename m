Return-Path: <hbausley@deltatau.com>
Received: from mail.deltatau.com (smtp.deltatau.com [64.60.44.211])
	by ozlabs.org (Postfix) with ESMTP id 22A13DE28A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 17:42:27 +1000 (EST)
Message-ID: <02f101c9074f$26d2cd90$0109220a@deltatau.local>
From: "Henry Bausley" <hbausley@deltatau.com>
To: <linuxppc-embedded@ozlabs.org>
References: <1219380814-17229-1-git-send-email-fkan@amcc.com><20080822133020.GE22283@yoda.jdub.homelinux.org>
	<200808222144.15235.sr@denx.de>
Subject: AMCC PPC460EX Canyonlands Hardwired interrupt
Date: Tue, 26 Aug 2008 00:41:27 -0700
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


How do I go about using one of the gpio pins for my own interrupt with the 
Canyonlands board.  Previously I used a yosemite (ppc) board and modified 
the yosemite.c file so that IRQ0 and IRQ1 were edge sensitive and and stole 
the ETH0/1 phy hardware interrupts for my own purposes and everything 
worked.

I am trying to do the same with the Canyonlands (powerpc) board.but cannot 
seem to enable the interrupt.

I am using the 2.6.26.2 denx kernel and xenomai 2.4.5 
