Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 10E7367BCF
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 09:08:17 +1000 (EST)
In-Reply-To: <1149645858.27572.93.camel@localhost.localdomain>
References: <1149645858.27572.93.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3EB64128-691F-4DB9-922E-C60CE739168F@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix cell blade detection
Date: Thu, 8 Jun 2006 01:09:42 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

> +#ifdef CONFIG_PPC64
> +			/* We must make sure we don't detect the IBM Cell
> +			 * blades as pSeries due to some firmware issues,
> +			 * so we do it here.
> +			 */

Is this #ifdef needed?  Do we really care about 22 bytes of rodata?


Segher
