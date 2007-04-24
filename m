Return-Path: <info@schihei.de>
In-Reply-To: <20070423202237.0725075a@localhost>
References: <20070423202237.0725075a@localhost>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <257C8A50-17BA-4EE2-B10F-7F95359E8EB5@schihei.de>
From: Heiko J Schick <info@schihei.de>
Subject: Re: [patch 2/2] powerpc: pmi probe device by device-type
Date: Tue, 24 Apr 2007 07:53:58 +0200
To: Christian Krafft <krafft@de.ibm.com>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Acked-by: Heiko J Schick <schickhj@de.ibm.com>

On 23.04.2007, at 20:22, Christian Krafft wrote:

> From: Christian Krafft <krafft@de.ibm.com>
> At the moment the pmi device driver is probing for devices with
> a given type and a given name. As there may be devices of
> the same type but with a different name, probing should be
> done also for device type only.
>
> Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
>
> Index: sdk3/arch/powerpc/sysdev/pmi.c
> ===================================================================
> --- sdk3.orig/arch/powerpc/sysdev/pmi.c
> +++ sdk3/arch/powerpc/sysdev/pmi.c
> @@ -103,6 +103,7 @@ out:
>
>  static struct of_device_id pmi_match[] = {
>  	{ .type = "ibm,pmi", .name = "ibm,pmi" },
> +	{ .type = "ibm,pmi" },
>  	{},
>  };
>
>
>
> -- 
> Mit freundlichen Gruessen,
> kind regards,
>
> Christian Krafft
> IBM Systems & Technology Group,
> Linux Kernel Development
> IT Specialist
>
>
> Vorsitzender des Aufsichtsrats:	Johann Weihen
> Geschaeftsfuehrung:		Herbert Kircher
> Sitz der Gesellschaft:		Boeblingen
> Registriergericht:		Amtsgericht Stuttgart, HRB 243294
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
