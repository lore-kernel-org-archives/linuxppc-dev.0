Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 41DA9DDDFE
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 23:23:51 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA1CNlOp009805
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 08:23:47 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA1CNlFk118038
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 06:23:47 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA1CNlvJ001179
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 06:23:47 -0600
Date: Thu, 1 Nov 2007 07:23:44 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: PPC405GP Walnut irq patch
Message-ID: <20071101072344.42e31913@weaponx.rchland.ibm.com>
In-Reply-To: <4728C0F5.80304@harris.com>
References: <47279CF0.4050600@harris.com> <4727A507.10309@harris.com>
	<20071030204015.06a699d7@vader.jdub.homelinux.org>
	<4728C0F5.80304@harris.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 31 Oct 2007 13:52:53 -0400
"Steven A. Falco" <sfalco@harris.com> wrote:

> > Could you redo the patch with just this bit and send it again?
> >
> > josh
> >     
> 
> Ok - this one is based off the Linus tree, and follows your style of one 
> interrupt per line, with a comment indicating which one it is.

Looks good.  Thanks!

josh

> 
> Signed-off-by: Steve Falco <sfalco at harris.com>
> 
> 
> 
> diff --git a/arch/powerpc/boot/dts/walnut.dts b/arch/powerpc/boot/dts/walnut.dts
> index fa681f5..754fa39 100644
> --- a/arch/powerpc/boot/dts/walnut.dts
> +++ b/arch/powerpc/boot/dts/walnut.dts
> @@ -122,7 +122,9 @@
>  				device_type = "network";
>  				compatible = "ibm,emac-405gp", "ibm,emac";
>  				interrupt-parent = <&UIC0>;
> -				interrupts = <9 4 f 4>;
> +				interrupts = <
> +					f 4 /* Ethernet */
> +					9 4 /* Ethernet Wake Up */>;
>  				local-mac-address = [000000000000]; /* Filled in by zImage */
>  				reg = <ef600800 70>;
>  				mal-device = <&MAL>;
