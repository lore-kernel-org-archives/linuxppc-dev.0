Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 39EDADDF97
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Sep 2007 11:14:02 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id l831E0Oh030283
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 11:14:00 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l831Dx603653832
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 11:13:59 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l831Dxo8016128
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Sep 2007 11:13:59 +1000
Date: Mon, 3 Sep 2007 11:11:12 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 5/6] Walnut board support
Message-ID: <20070903011112.GE31499@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>>
	<20070831200643.514442000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070831200643.514442000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 31, 2007 at 03:04:54PM -0500, Josh Boyer wrote:
> Board support for the PPC405 Walnut evaluation board
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

[snip]
> --- linux-2.6.orig/arch/powerpc/platforms/40x/Kconfig
> +++ linux-2.6/arch/powerpc/platforms/40x/Kconfig
> @@ -53,13 +53,13 @@
>  #	help
>  #	  This option enables support for the IBM PPC405GPr evaluation board.
>  
> -#config WALNUT
> -#	bool "Walnut"
> -#	depends on 40x
> -#	default y
> -#	select 405GP
> -#	help
> -#	  This option enables support for the IBM PPC405GP evaluation board.
> +config WALNUT
> +	bool "Walnut"
> +	depends on 40x
> +	default y
> +	select 405GP
> +	help
> +	  This option enables support for the IBM PPC405GP evaluation board.

Surely this needs WANT_DEVICE_TREE, too.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
