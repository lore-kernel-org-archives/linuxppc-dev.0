Return-Path: <jdl@freescale.com>
Subject: Re: [PATCH 11/13] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
From: Jon Loeliger <jdl@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20070427204148.GA14490@mag.az.mvista.com>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<20070426000151.GM4046@mag.az.mvista.com>
	<20070427204148.GA14490@mag.az.mvista.com>
Content-Type: text/plain
Message-Id: <1177951541.4616.4.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 30 Apr 2007 11:45:41 -0500
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-04-27 at 15:41, Mark A. Greer wrote:
> [PATCH 11/13] powerpc: Add DTS file for the Motorola PrPMC2800 platform
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>
> ---
> 
>  prpmc2800.dts |  321 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 321 insertions(+)
> 
> Index: powerpc/arch/powerpc/boot/dts/prpmc2800.dts
> ===================================================================
> --- /dev/null
> +++ powerpc/arch/powerpc/boot/dts/prpmc2800.dts
> @@ -0,0 +1,321 @@
> +/* Device Tree Source for Motorola PrPMC2800
> + *
> + * Author: Mark A. Greer <mgreer@mvista.com>
> + *
> + * 2007 (c) MontaVista, Software, Inc.  This file is licensed under
> + * the terms of the GNU General Public License version 2.  This program
> + * is licensed "as is" without any warranty of any kind, whether express
> + * or implied.
> + *
> + * To build:
> + *   dtc -I dts -O asm -o prpmc2800.S -V 16 -b 0 prpmc2800.dts
> + *   dtc -I dts -O dtb -o prpmc2800.dtb -V 16 -b 0 prpmc2800.dts

Any real reason to keep the -V 16 in there?
If not, please remove this advice!

Thanks,
jdl
