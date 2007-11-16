Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BCF68DDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Nov 2007 15:37:48 +1100 (EST)
Message-Id: <4E0EFED3-8697-4768-9D89-A2443AEC82A5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Clemens Koller <clemens.koller@anagramm.de>
In-Reply-To: <473C7FCC.7050307@anagramm.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Latest paulus.git PCI broken on mpc8540?
Date: Thu, 15 Nov 2007 22:37:36 -0600
References: <473C7FCC.7050307@anagramm.de>
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


On Nov 15, 2007, at 11:20 AM, Clemens Koller wrote:

> Hi there!
>
> I try to use the latest Linux-2.6.24-rc2-ge6a5c27f from paulus.git
> for my mpc8540ads compatible board.
>
> $ dmesg contains some nasty messages, which look like something is  
> wrong.
>
> PCI: Probing PCI hardware
> PCI: Cannot allocate resource region 0 of device 0000:00:12.0
> PCI: Cannot allocate resource region 1 of device 0000:00:12.0
> PCI: Cannot allocate resource region 2 of device 0000:00:12.0
> PCI: Cannot allocate resource region 3 of device 0000:00:12.0
> PCI: Cannot allocate resource region 4 of device 0000:00:12.0
> PCI: Cannot allocate resource region 0 of device 0000:00:14.0
> PCI: Cannot allocate resource region 2 of device 0000:00:14.0

this isn't really an error.  Its more of a warning, the kernel will  
try and allocate these later and I'm guessing based on what you are  
seeing it succeeded.

Benh, can we possibly change these messages in pci_32.c?

- k
