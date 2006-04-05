Return-Path: <kevinmorizur@hotmail.fr>
Received: from hotmail.com (bay109-f18.bay109.hotmail.com [64.4.19.28])
	by ozlabs.org (Postfix) with ESMTP id A18FB679EF
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Apr 2006 21:06:48 +1000 (EST)
Message-ID: <BAY109-F187E08DFC53AE3753CC9F5A1CB0@phx.gbl>
From: "kevin morizur" <kevinmorizur@hotmail.fr>
To: linuxppc-embedded@ozlabs.org
Subject: SBC 8245 problem with linux kernel PCI bus configuration
Date: Wed, 05 Apr 2006 12:49:41 +0200
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi.
I'am using a SBC8245 board,ELDK 4.0 and Linux 2.6.11.
I make a linux kernel for MPC8245 with ELDK version 4.0 and i meet few 
problems :

1) I make my kernel configuration and when i activate the PCI bus support i 
have errors in compilation: PIRQA,PIRQB,PIRQC,PIRQD, 
PCI_INT_MASK_REG,PCI_INT_STAT_REG,PCI_INT_TO_SIU are not defined. When i 
compile without PCI bus support, there is no problem. So i don't have PCI 
bus activate !

2) When i start the kernel on my target the console displays : Detected 
PPCBOOT header
                    Verifying image CRC...ok
                    Uncompressing Kernel Image...ok
                    Starting Linux Kernel.
and it stops. My console is connected via the serial port which is connected 
to the MPC8245 via PCI bus. So maybe the linux kernel starts correctly but i 
can't see anything ?

So if you could help me to make PCI bus working correctly !

Regards,
Kevin

_________________________________________________________________
Tout savoir sur la sécurité de votre PC ! 
http://go.msn.fr/10-channel/80-security/spam/default.asp
