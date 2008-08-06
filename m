Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 90012DECCD
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 03:29:26 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m76HTKDI017326
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 10:29:21 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m76HTKYH019894
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Aug 2008 12:29:20 -0500 (CDT)
Date: Wed, 6 Aug 2008 12:29:20 -0500
From: Scott Wood <scottwood@freescale.com>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 5/6] powerpc: add USB peripheral support to MPC836xMDS
Message-ID: <20080806172920.GC3138@ld0162-tx32.am.freescale.net>
References: <1218006285-27138-1-git-send-email-leoli@freescale.com>
	<1218006285-27138-2-git-send-email-leoli@freescale.com>
	<1218006285-27138-3-git-send-email-leoli@freescale.com>
	<1218006285-27138-4-git-send-email-leoli@freescale.com>
	<1218006285-27138-5-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1218006285-27138-5-git-send-email-leoli@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 06, 2008 at 03:04:44PM +0800, Li Yang wrote:
>  		usb@6c0 {
> -			compatible = "qe_udc";
> +			compatible = "fsl,qe_udc";
[snip]
> +
> +		np = of_find_compatible_node(NULL, NULL, "fsl,qe_udc");
> +		if (np) {
> +			par_io_of_config(np);
> +			qe_usb_clock_set(np);
> +		}

What about existing device trees in use?

> +		printk(KERN_ERR "Unsupport usb-clock input pin\n");

s/Unsupport/Unsupported/

-Scott
