Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 27050DDE9A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 11:50:43 +1100 (EST)
Message-ID: <4744D2AE.60902@freescale.com>
Date: Wed, 21 Nov 2007 18:51:58 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
	Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] [POWERPC] Add docs for Freescale DMA & DMA channel
	device tree nodes
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>	<Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>	<474447EF.8080405@freescale.com>	<E9CED991-4E10-44AE-A446-B6CB151FB9EE@kernel.crashing.org>	<20071121173540.GC4413@loki.buserror.net>	<8B189FFE-F45E-470C-87A0-E9FC61A1CF59@kernel.crashing.org>	<47448687.6010106@freescale.com>
	<20071121222822.GB19445@localhost.localdomain>
In-Reply-To: <20071121222822.GB19445@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:

> Indeed, indexing or writing into shared registers is exactly what
> cell-index is for.

I don't care whether it's cell-index or device-id, but I need to know which 
DMA controller is #0 and which one is #1, and I need to know which channel is 
#0, which one is #1, etc.  Dividing register offsets by 0x80 is not 
acceptable, because what if we have an elo-plus-plus that has 0x100 bytes per 
register, where the additional 0x20 bytes are for enhanced features?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
