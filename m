Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F49DDDFDA
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:33:30 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9NFXRfp032467
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 11:33:27 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9NFXIEi073382
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 09:33:18 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9NFXIZ3009667
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 09:33:18 -0600
Date: Tue, 23 Oct 2007 10:33:16 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] PowerPC 440EPx Sequoia USB OHCI DTS entry
Message-ID: <20071023103316.471f8afa@weaponx.rchland.ibm.com>
In-Reply-To: <20071008142658.GA15197@ru.mvista.com>
References: <20071008142658.GA15197@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 8 Oct 2007 18:26:58 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> PowerPC 440EPx Sequoia USB OHCI device tree entry.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

I think I saw the OHCI big endian quirk patch go into Linus' tree
recently.  Is that the only patch this one depends on?

josh

> ---
>  arch/powerpc/boot/dts/sequoia.dts |    7 +++++++
>  1 files changed, 7 insertions(+)
> 
> diff -pruN linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts linux-2.6/arch/powerpc/boot/dts/sequoia.dts
> --- linux-2.6.orig/arch/powerpc/boot/dts/sequoia.dts	2007-10-08 16:29:54.000000000 +0400
> +++ linux-2.6/arch/powerpc/boot/dts/sequoia.dts	2007-10-08 17:56:05.000000000 +0400
> @@ -122,6 +122,13 @@
>  			interrupt-map-mask = <ffffffff>;
>  		};
> 
> +		USB1: usb@e0000400 {
> +			compatible = "ohci-be";
> +			reg = <0 e0000400 60>;
> +			interrupt-parent = <&UIC0>;
> +			interrupts = <15 8>;
> +		};
> +
>  		POB0: opb {
>  		  	compatible = "ibm,opb-440epx", "ibm,opb";
>  			#address-cells = <1>;
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
