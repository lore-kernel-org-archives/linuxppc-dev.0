Return-Path: <gmuruga@gdatech.com>
Received: from darwaza.gdatech.com (darwaza.gdatech.com [66.237.41.98])
	by ozlabs.org (Postfix) with ESMTP id E7337DDEC1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jun 2007 02:47:51 +1000 (EST)
Date: Fri, 29 Jun 2007 09:48:28 -0700
Message-Id: <200706291648.l5TGmSS17074@sierra.gdatech.com>
From: "Muruga Ganapathy" <gmuruga@gdatech.com>
To: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>,
	"Nicholas Hickman" <nhickman@dtechlabs.com>, linuxppc-embedded@ozlabs.org
Subject: Re: mpc8270 & Intel 82551ER on 2.6.17.14
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



1. You may want to check whether the device is configured properly by
   enabling the debug statements or using the lspci command. I mean the 
   BAR registers.

2. Also check whether correct the interrupt is assigned to the 
   device using cat /proc/interrupts command under linux. 

3. As far as the EEPROM is concerned, you need to enable debug to check 
   whether there is any check sum error. If there is a check sum error 
   in EEPROM, the device may not come up too. As you are using it in 
   powerpc platform, you need to take care of the endianess while 
   writing to the EEPROM.

Hope this helps!

Thanks
G.Muruganandam



> Hi Nicholas,
> 
> On 6/29/07, Nicholas Hickman <nhickman@dtechlabs.com> wrote:
> >
> >
> > I am having trouble getting two 82551ER Ethernet controllers 
running in
> > Linux.  I am able to scan the PCI bus and see the devices and I was 
even
> > able to program the EEPROM from U-boot.
> >
> > In the kernel I mapped the IRQ's through /arch/ppc/m82xx_pci.c.  
I've been
> > using the e100 drive that comes with the 2.6.17.14 kernel and have 
also
> > tried the driver directly from Intel.  Both give the same results.  
The PCI
> > scan shows the correct output for how the device should be 
configured.
> <snip..>
> 
> I have the same, exact same problem. But there are some of the
> differences with the setup though. I have an MPC5200B and the other
> difference is that I have a 2.6.21-rt3. However its the same ethernet
> controller.
> 
> I am trying out a few things here, some of them being complete
> guesses. But if I hit something, I will let this list know. Anyone
> else had similar issues ? Request you to please holler.
> 
> regards
> prady
> -- 
> htp://prady.livejournal.com
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

*************************************************************
GDA Technologies, Inc.		
1010 Rincon Circle 
San Jose CA, 95131
Phone	(408) 432-3090
Fax	(408) 432-3091

Accelerate Your Innovation	
**************************************************************


=====
This message contains information from GDA Technologies Inc and 
affiliates, and is intended for the sole use of the individual and 
entity to whom it is addressed. It may contain information, including 
any attachments, that is privileged, confidential and exempt from 
disclosure under applicable law. If you are not the intended addressee, 
nor authorized to receive for the intended addressee, you are hereby 
notified that you may not use, copy, disclose or distribute to anyone 
the message or any information contained in the message. If you have 
received this electronic transmission in error, please notify the 
sender immediately by a "reply to sender only" message and destroy all 
electronic and hard copies of the communication, including attachments.
====
