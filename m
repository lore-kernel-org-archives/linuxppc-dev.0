Return-Path: <dgibson@ozlabs.org>
Date: Mon, 22 Oct 2007 10:36:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Olof Johansson <olof@lixom.net>
Subject: Re: ep88xc_defconfig doesn't build
Message-ID: <20071022003625.GC17164@localhost.localdomain>
References: <20071020024355.GA20356@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071020024355.GA20356@lixom.net>
Cc: linuxppc-dev@ozlabs.org, scott.wood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 09:43:55PM -0500, Olof Johansson wrote:
> Hi,
> 
> Did it ever?! I get this with current mainline when building default target:

I think you must have an old dtc; I'm pretty sure I removed the check
for /chosen some time ago.  But then I also thought we added a force
to the dtc commant line in wrapper ages ago, so now I'm a bit confused.

>   WRAP    arch/powerpc/boot/cuImage.8xx
> DTC: dts->dtb  on file "/work/work/linux/k.org/arch/powerpc/boot/dts/ep88xc.dts"
> ERROR: Missing /chosen node
> Input tree has errors
>   WRAP    arch/powerpc/boot/zImage.ep88xc
> make[1]: *** [arch/powerpc/boot/cuImage.8xx] Error 1
> make[1]: *** Waiting for unfinished jobs....
> DTC: dts->dtb  on file "/work/work/linux/k.org/arch/powerpc/boot/dts/ep88xc.dts"
> ERROR: Missing /chosen node
> Input tree has errors
> make[1]: *** [arch/powerpc/boot/zImage.ep88xc] Error 1
> make: *** [zImage] Error 2
> 
> 
> 
> -Olof
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
