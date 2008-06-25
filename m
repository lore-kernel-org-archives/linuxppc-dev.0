Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE265DE194
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 08:30:43 +1000 (EST)
Date: Wed, 25 Jun 2008 17:30:31 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] mpc8313erdb: Add power management to the device tree.
Message-Id: <20080625173031.ebe238eb.kim.phillips@freescale.com>
In-Reply-To: <20080625215139.GC11784@loki.buserror.net>
References: <20080625215139.GC11784@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 25 Jun 2008 16:51:39 -0500
Scott Wood <scottwood@freescale.com> wrote:

> +			crypto@30000 {
> +				device_type = "crypto";
> +				model = "SEC2";

I thought we were done with the two above properties..

> +				compatible = "fsl,sec2.2", "fsl,sec2.1",
> +				             "fsl,sec2.0";
> +				reg = <0x30000 0x7000>;
> +				interrupts = <11 0x8>;
> +				interrupt-parent = <&ipic>;
> +				/* Rev. 2.2 */
> +				num-channels = <1>;
> +				channel-fifo-len = <24>;
> +				exec-units-mask = <0x0000004c>;
> +				descriptor-types-mask = <0x0122003f>;

..and prefixed the above four with "fsl,", as in:

http://patchwork.ozlabs.org/linuxppc/patch?id=18726

what's the status of that patch, btw?

Kim
