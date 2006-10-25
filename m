Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 27E6D67A2E
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 19:30:57 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k9PApjql028189
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 04:51:45 -0600 (MDT)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k9P9UqNT010072
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 04:30:54 -0500 (CDT)
Subject: Re: MPC7448_HPC2 question
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1161753605.22582.42.camel@localhost.localdomain>
References: <1161753605.22582.42.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1161768688.17597.8.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 25 Oct 2006 17:31:29 +0800
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

On Wed, 2006-10-25 at 13:20, Benjamin Herrenschmidt wrote:

> 
> Cannot be replaced by:
> 
>         pci_read_irq_line(dev);

When I use pci_read_irq_line(), the pci interrupt number exceeds the
limit of mpic-> irq_count. my mpic->irq_count = 0x18, which is gotten
from on chip register. 

mpic_host_map() can not return successful value.

Roy
