Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED52ADDEB8
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 02:44:03 +1100 (EST)
Message-ID: <474AE9D3.3070205@freescale.com>
Date: Mon, 26 Nov 2007 09:44:19 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 3/3] [POWERPC] Add docs for Freescale DMA & DMA channel
	device tree nodes
References: <Pine.LNX.4.64.0711202310280.24220@blarg.am.freescale.net>	<Pine.LNX.4.64.0711202314030.24220@blarg.am.freescale.net>	<474447EF.8080405@freescale.com>	<E9CED991-4E10-44AE-A446-B6CB151FB9EE@kernel.crashing.org>	<20071121173540.GC4413@loki.buserror.net>	<8B189FFE-F45E-470C-87A0-E9FC61A1CF59@kernel.crashing.org>	<47448687.6010106@freescale.com>
	<20071121222822.GB19445@localhost.localdomain>
	<4744D2AE.60902@freescale.com>
In-Reply-To: <4744D2AE.60902@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> David Gibson wrote:
> 
>> Indeed, indexing or writing into shared registers is exactly what
>> cell-index is for.
> 
> I don't care whether it's cell-index or device-id, but I need to know 
> which DMA controller is #0 and which one is #1, and I need to know which 
> channel is #0, which one is #1, etc.

OK, cell-index makes sense there too, then.

-Scott
