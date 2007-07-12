Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C50FDDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 19:00:19 +1000 (EST)
In-Reply-To: <1184228873.27622.11.camel@localhost.localdomain>
References: <1184082728.20129.187.camel@localhost.localdomain>
	<963D5B48-F1E5-4930-9F29-98D7F0E33C0A@kernel.crashing.org>
	<1184121840.22066.24.camel@localhost.localdomain>
	<0E17851B-A642-43E2-9A5D-39DFC6F30E77@kernel.crashing.org>
	<7431AAFD-73B7-4337-94CB-878285D298E3@kernel.crashing.org>
	<1184228873.27622.11.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2EA16557-7960-4A1A-9D07-BDA3D8843460@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch 3/6] Add 8548 CDS PCI express controller node and PCI-X
	device node
Date: Thu, 12 Jul 2007 04:00:24 -0500
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 12, 2007, at 3:27 AM, Zang Roy-r61911 wrote:

> From: Roy Zang <tie-fei.zang@freescale.com>
>
> Add 8548 CDS PCI express controller node and PCI-X device node.
> The current  dts file is suitable for 8548 Rev 2.0 board with
> Arcadia 3.1.
> This kind of board combination is the most popular.
>
> Indentify pci, pcie host by compatible property "fsl,mpc85xx-pci"
> and "fsl, mpc85xx-pciex".
>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> ---
> Fix the PCI Express b,c,d, irq sense.

is this the only fix, I've already applied a version of this to my  
tree (with the irq sense fix) and just want to make sure there isn't  
anything else.

- k
