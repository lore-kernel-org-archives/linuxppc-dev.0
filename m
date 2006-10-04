Return-Path: <gmuruga@gdatech.com>
Received: from darwaza.gdatech.com (darwaza.gdatech.com [66.237.41.98])
	by ozlabs.org (Postfix) with ESMTP id 24B8667C20
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 11:11:50 +1000 (EST)
Date: Tue, 3 Oct 2006 18:12:16 -0700
Message-Id: <200610040112.k941CG112451@sierra.gdatech.com>
From: "Muruga Ganapathy" <gmuruga@gdatech.com>
To: David Hawkins <dwh@ovro.caltech.edu>,
	Eric Heim <sheldoninstruments@yahoo.com>, linuxppc-embedded@ozlabs.org
Subject: Re: Windows boot recognition
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


You may need to configure the board in PCI agent mode so that it can
respond to the PCI configuration cycles. By fefault, it might come 
in master mode ( wherein it generates the PCI cycles and configures 
other devices in its PCI bus)

It should be a hardware configuration option. So you should see a 
jumper on the board or you may need to mount/unmount a resistor.
Pl check the hardware user manual.

Thanks
G.Muruganandam


> Hi Tim,
> 
> > I am trying to develop a windows driver for the MPC8349MDS board 
but 
> > Windows does not seem to acknowledge the existence of the board in 
the 
> > pci slot.  The device manager does not see the board and no 
resources 
> > are allocated on boot.
> 
> If no resources are allocated on boot, then it indicates the BIOS
> has not found the board. Have you booted this same machine under
> Linux? If not, grab a Knoppix or Ubuntu CD and boot the machine
> and see if lspci sees the board.
> 
> > Running Linux as my OS works perfectly.  I have 
> > tried both Windows 2000 and XP on two different machines.  Any 
ideas?
> 
> Under Windows I've used a tool called PCI tree to find
> PCI resources of boards, it'll even let you manipulate
> config space registers (much like setpci can under Linux).
> Try running that tool to see if the board is setup
> correctly by the BIOS.
> 
> If your Windows and Linux development machines are different,
> then you may just be fighting with hardware. So first confirm
> that the BIOS is finding the board.
> 
> Also check for hardware differences between the development
> machines; eg. 33MHz or 66MHz, 32-bit or 64-bit PCI.
> 
> Dave
> 
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
disclosure under applicable law. If you are not the intended 
addressee, nor authorized to receive for the intended addressee, you 
are hereby notified that you may not use, copy, disclose or distribute 
to anyone the message or any information contained in the message. If 
you have received this electronic transmission in error, please notify 
the sender immediately by a "reply to sender only" message and destroy 
all electronic and hard copies of the communication, including 
attachments.
====
