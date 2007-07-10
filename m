Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E7CEFDDE2C
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 06:28:55 +1000 (EST)
In-Reply-To: <1184082783.20129.193.camel@localhost.localdomain>
References: <1184082783.20129.193.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FFEC5443-109B-45B7-80CA-0252F9365B55@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 5/6] Update the 83xx/85xx/86xx boards device tree
Date: Tue, 10 Jul 2007 22:28:44 +0200
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

> Indentify pci, pcie host by compatible property
> "fsl,mpc83xx-pci","83xx"
> "fsl,mpc85xx-pci","85xx"
> "fsl,mpc86xx-pci","86xx"
> and
> "fsl, mpc85xx-pciex","85xx"
> "fsl, mpc86xx-pciex","86xx"

This can't ever work -- if you see "compatible" = "85xx",
what is it?  PCI or PCIe?  Or something else perhaps, maybe
a CPU or an I2C controller or who-knows-what?


Segher
