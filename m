Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 24E35DDE19
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 06:06:51 +1000 (EST)
In-Reply-To: <1180685138.17196.55.camel@localhost.localdomain>
References: <1180685138.17196.55.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0A55A77D-FAD9-449D-AC36-1772B718D054@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [patch] powerpc: Remove redundant pci_read_irq_line() function
	for 85xx platform
Date: Fri, 1 Jun 2007 15:06:59 -0500
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


On Jun 1, 2007, at 03:05, Zang Roy-r61911 wrote:

> From: Roy Zang <tie-fei.zang@freescale.com>
>
> Remove redundant pci_read_irq_line() function for
> 85xx CDS board.
> This function has been realized in common pci_32.c.
>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>

Acked-by: Andy Fleming <afleming@freescale.com>
