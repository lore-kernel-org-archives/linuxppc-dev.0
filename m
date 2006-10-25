Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 57FA567BF4
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 23:45:45 +1000 (EST)
Subject: Re: MPC7448_HPC2 question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <1161768688.17597.8.camel@localhost.localdomain>
References: <1161753605.22582.42.camel@localhost.localdomain>
	<1161768688.17597.8.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 23:45:36 +1000
Message-Id: <1161783936.22582.89.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"Alexandre.Bounine@tundra.com" <Alexandre.Bounine@tundra.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-25 at 17:31 +0800, Zang Roy-r61911 wrote:
> On Wed, 2006-10-25 at 13:20, Benjamin Herrenschmidt wrote:
> 
> > 
> > Cannot be replaced by:
> > 
> >         pci_read_irq_line(dev);
> 
> When I use pci_read_irq_line(), the pci interrupt number exceeds the
> limit of mpic-> irq_count. my mpic->irq_count = 0x18, which is gotten
> from on chip register. 
> 
> mpic_host_map() can not return successful value.

That is not normal... Something must be wrong with your code or your
DT... can you get more details about what precisely is happening in both
cases ?

Ben.
