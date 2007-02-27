Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 95870DDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 10:24:13 +1100 (EST)
In-Reply-To: <200702272223.l1RMNKcF030373@ld0164-tx32.am.freescale.net>
References: <200702272223.l1RMNKcF030373@ld0164-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <02cb84d7709d1b86ce33030c297c0de1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: update interrupt info in booting-without-of.txt
Date: Wed, 28 Feb 2007 00:23:30 +0100
To: Stuart Yoder <b08248@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +Devices that generate interrupts have an 'interrupt parent' in
> +the interrupt tree.  An interrupt parent can be explicitly
> +defined through the interrupt-parent property. For nodes with
> +no interrupt-parent, the interrupt parent is assumed to be
> +the node's  _device tree_ parent.

Or its parent, or its grandparent, etc.

> +The encoding of an interrupt specifier is determined by the
> +domain (or nexus)

Domain.  An interrupt nexus is to the interrupt tree
what a node is to the device tree.

> +The PCI bus binding specifies a #interrupt-cell value of 1 to encode
> +which interrupt line (INTA,INTB,INTC,INTD) is used.

s/line/pin/ to agree with PCI terminology.

> +The interrupt-parent property is specified to define an explicit
> +link between a device node and its interrupt parent in
> +the interrupt tree.  The value of interrupt-parent is the
> +phandle to the parent node.

phandle _of_ the parent node please.

> +If the interrupt-parent property is not defined for a node, it's
> +interrupt parent is assumed to be it's device tree_ parent.

Same thing again.  You missed an underscore, too.

> +OpenPIC interrupt controllers required 2 cells to encode

s/required/require/

> +ISA PIC interrupt controllers required 2 cells to encode

same thing


Looks good otherwise, thanks.


Segher
