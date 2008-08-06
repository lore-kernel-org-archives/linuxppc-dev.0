Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 434AFDE258
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 03:19:56 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m76HJpvS024361
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 10:19:51 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m76HJosa023663
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 12:19:50 -0500 (CDT)
Date: Wed, 6 Aug 2008 12:19:50 -0500
From: Scott Wood <scottwood@freescale.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 4/6] powerpc: add USB peripheral support to MPC8272ADS
Message-ID: <20080806171949.GA3138@ld0162-tx32.am.freescale.net>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<1218006285-27138-3-git-send-email-leoli@freescale.com>
	<1218006285-27138-4-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1218006285-27138-4-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 06, 2008 at 03:04:43PM +0800, Li Yang wrote:
> Signed-off-by: Li Yang <leoli@freescale.com>
> ---
>  arch/powerpc/boot/dts/mpc8272ads.dts      |    8 ++++++++
>  arch/powerpc/platforms/82xx/mpc8272_ads.c |   25 +++++++++++++++++++++++++
>  arch/powerpc/platforms/82xx/pq2ads.h      |    3 +++
>  3 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
> index b2ce4c0..75cc94c 100644
> --- a/arch/powerpc/boot/dts/mpc8272ads.dts
> +++ b/arch/powerpc/boot/dts/mpc8272ads.dts
> @@ -256,6 +256,14 @@
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  			};
> +
> +			usb@11b60 {
> +				compatible = "fsl,qe_udc";

"fsl,mpc8272-usb", "fsl,cpm2-usb".

Where is fsl,qe_udc documented or used (other than in the BCSR setup)?
What does "udc" mean (the only reference to it in the 8272 manual is
under ATM)?

> +				mode = "slave";

Please document this property.

-Scott
