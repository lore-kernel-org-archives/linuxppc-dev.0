Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E6501DDF96
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 08:24:47 +1000 (EST)
Message-ID: <48C6F7AA.2000608@freescale.com>
Date: Tue, 09 Sep 2008 17:24:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jeff Brower <jbrower@signalogic.com>
Subject: Re: driver replacements for kmalloc and __pa()
References: <48C6F217.406CFDC0@signalogic.com>
In-Reply-To: <48C6F217.406CFDC0@signalogic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jeff Brower wrote:
> What are the up-to-date APIs we should be using for DMA memory allocation and
> virtual-to-physical address translation?  We have another driver for another device
> that's working fine on this board and it uses pci_alloc_consistent().  What about
> bus_space_vaddr()?  I'm hoping to get a recommendation for what's currently
> appropriate and most future-proof for drivers that depend on external PCI DMA.

Documentation/DMA-API.txt.

-Scott
