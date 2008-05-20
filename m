Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7318ADDFF9
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 23:08:31 +1000 (EST)
Message-Id: <3AFD505F-CE8E-442A-9BE6-CF6425EE50FF@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <f4219729e8da75f5176347d176430d4b8b0fcb8a.1211287582.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] Add kernstart_addr to list of allowed symbols in prom_init
Date: Tue, 20 May 2008 08:08:18 -0500
References: <f4219729e8da75f5176347d176430d4b8b0fcb8a.1211287582.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	kamalesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 20, 2008, at 7:48 AM, Michael Ellerman wrote:

> Since commit "85xx: Add support for relocatable kernel (and
> booting at non-zero)" (37dd2badcfcec35f5e21a0926968d77a404f03c3),
> PHYSICAL_START is #defined as kernstart_addr if RELOCATABLE
> and FLATMEM is enabled.
>
> PHYSICAL_START is used in prom_init.c and so kernstart_addr
> needs to be added to the list of allowed symbols that
> prom_init.c can access.
>
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
