Return-Path: <jakob.viketoft@bitsim.com>
Received: from amsfep15-int.chello.nl (amsfep15-int.chello.nl [213.46.243.28])
	by ozlabs.org (Postfix) with ESMTP id 9E2FB67A46
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Feb 2005 21:28:08 +1100 (EST)
Received: from [192.168.0.27] (really [80.216.174.242])
	by amsfep13-int.chello.nl
	(InterMail vM.6.01.03.04 201-2131-111-106-20040729) with ESMTP
	id <20050203100928.MSLB11192.amsfep13-int.chello.nl@[192.168.0.27]>
	for <linuxppc-embedded@ozlabs.org>; Thu, 3 Feb 2005 11:09:28 +0100
Message-ID: <4201F956.1050702@bitsim.com>
Date: Thu, 03 Feb 2005 11:13:42 +0100
From: Jakob Viketoft <jakob.viketoft@bitsim.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Linux on Virtex-II Pro P20 development board...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello everyone!

I've just started trying to get the Linux (2.6.8.1) kernel to run on the 
above mentioned board (or, specifically, a PPC405 on the Xilinx 
Virtex-II Pro 2VP20). I just figured I'd ask around and see if any of 
you have got this board running and then what kernel modifications where 
necessary and IP blocks (from the development kit) you've used. At the 
moment I'm primarily interested in the PPC and a serial port, later on 
the TP port will be useful as well.

I've previously ported the 2.4.x kernel to Cirrus Logic EP7312 (ARM) 
chip, but that was some years ago and with the new kernel, chip and 
structure of the PPC arch of the kernel I'm a bit disoriented. Any help 
would be greatly appreciated!

Regards,
	/Jakob
