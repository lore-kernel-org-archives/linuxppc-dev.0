Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D399DDDF2
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Nov 2007 16:35:44 +1100 (EST)
Subject: Re: Latest paulus.git PCI broken on mpc8540?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4E0EFED3-8697-4768-9D89-A2443AEC82A5@kernel.crashing.org>
References: <473C7FCC.7050307@anagramm.de>
	<4E0EFED3-8697-4768-9D89-A2443AEC82A5@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 16 Nov 2007 16:35:33 +1100
Message-Id: <1195191333.28865.140.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Thu, 2007-11-15 at 22:37 -0600, Kumar Gala wrote:
> > PCI: Probing PCI hardware
> > PCI: Cannot allocate resource region 0 of device 0000:00:12.0
> > PCI: Cannot allocate resource region 1 of device 0000:00:12.0
> > PCI: Cannot allocate resource region 2 of device 0000:00:12.0
> > PCI: Cannot allocate resource region 3 of device 0000:00:12.0
> > PCI: Cannot allocate resource region 4 of device 0000:00:12.0
> > PCI: Cannot allocate resource region 0 of device 0000:00:14.0
> > PCI: Cannot allocate resource region 2 of device 0000:00:14.0
> 
> this isn't really an error.  Its more of a warning, the kernel will  
> try and allocate these later and I'm guessing based on what you are  
> seeing it succeeded.
> 
> Benh, can we possibly change these messages in pci_32.c?

Heh, well, I've been working on 44x PCI lately and got annoyed by the
exact same messages, though I'm still pondering what would be a better
replacement.

Ben
