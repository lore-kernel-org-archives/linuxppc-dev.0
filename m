Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4D6D8DDF7C
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Jun 2008 22:38:31 +1000 (EST)
Message-ID: <485F993F.9060101@freescale.com>
Date: Mon, 23 Jun 2008 07:38:23 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: rh_init exported twice (rheap vs. dm-region_hash)
References: <485F9806.1000408@genesi-usa.com>
In-Reply-To: <485F9806.1000408@genesi-usa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Matt Sealey wrote:

> I was thinking of renaming the dm hash one to rh_hash_init() and then I
> thought, maybe rh_heap_init() is better. Then I thought, why have rh in
> both places, why not rename the entire API (rheap_ and rhash_) in both
> cases?

I'm okay with renaming the rh_xxx calls in rheap.c to rheap_xxx.  I also think 
renaming the rh_ calls to rhash is a good idea.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
