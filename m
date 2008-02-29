Return-Path: <dgibson@ozlabs.org>
Date: Fri, 29 Feb 2008 13:17:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexandr Smirnov <asmirnov@ru.mvista.com>
Subject: Re: [PATCH 2/4] Emerson KSI8560 device tree
Message-ID: <20080229021705.GA482@localhost.localdomain>
References: <20080228183503.GA26971@ru.mvista.com>
	<20080228184727.GC26971@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080228184727.GC26971@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 28, 2008 at 09:47:27PM +0300, Alexandr Smirnov wrote:
> 
> diff --git a/arch/powerpc/boot/dts/ksi8560.dts
> b/arch/powerpc/boot/dts/ksi8560.dts

What Scott said, plus:

[snip]
> +		i2c@3000 {
> +			device_type = "i2c";

No device_type here either.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
