Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-06.arcor-online.net
	[151.189.21.46])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 432EC67BBB
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 08:58:29 +1000 (EST)
In-Reply-To: <20060607012359.D59C467B37@ozlabs.org>
References: <20060607012359.D59C467B37@ozlabs.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4AE0F2C6-99B7-40AF-AB28-71D51C1141A5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: oprofile support for POWER6
Date: Thu, 8 Jun 2006 00:59:53 +0200
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>  	/*
> -	 * SIHV / SIPR bits are only implemented on POWER4+ (GQ) and above.
> -	 * However we disable it on all POWER4 until we verify it works
> -	 * (I was seeing some strange behaviour last time I tried).
> -	 *
> -	 * It has been verified to work on POWER5 so we enable it there.
> -	 */

The patched code doesn't handle GQ at all.  Is this on purpose?  Add a
similar comment to the CPU feature tables perhaps?


Segher
