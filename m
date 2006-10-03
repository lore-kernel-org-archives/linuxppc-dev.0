Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 9127B67C9D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Oct 2006 09:19:48 +1000 (EST)
Message-ID: <4522EFE1.7000905@ovro.caltech.edu>
Date: Tue, 03 Oct 2006 16:18:57 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Eric Heim <sheldoninstruments@yahoo.com>
Subject: Re: Windows boot recognition
References: <20061003221526.59074.qmail@web37813.mail.mud.yahoo.com>
In-Reply-To: <20061003221526.59074.qmail@web37813.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Tim,

> I am trying to develop a windows driver for the MPC8349MDS board but 
> Windows does not seem to acknowledge the existence of the board in the 
> pci slot.  The device manager does not see the board and no resources 
> are allocated on boot.

If no resources are allocated on boot, then it indicates the BIOS
has not found the board. Have you booted this same machine under
Linux? If not, grab a Knoppix or Ubuntu CD and boot the machine
and see if lspci sees the board.

> Running Linux as my OS works perfectly.  I have 
> tried both Windows 2000 and XP on two different machines.  Any ideas?

Under Windows I've used a tool called PCI tree to find
PCI resources of boards, it'll even let you manipulate
config space registers (much like setpci can under Linux).
Try running that tool to see if the board is setup
correctly by the BIOS.

If your Windows and Linux development machines are different,
then you may just be fighting with hardware. So first confirm
that the BIOS is finding the board.

Also check for hardware differences between the development
machines; eg. 33MHz or 66MHz, 32-bit or 64-bit PCI.

Dave
