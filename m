Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 72DDADE225
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 04:06:59 +1000 (EST)
Message-ID: <481B5870.2010000@freescale.com>
Date: Fri, 02 May 2008 13:07:44 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH v2.6.26] powerpc: Fix a bunch of sparse warnings in the
	qe_lib
References: <1209751415-25612-1-git-send-email-afleming@freescale.com>
In-Reply-To: <1209751415-25612-1-git-send-email-afleming@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andy Fleming wrote:
> +	struct qe_iram __iomem	iram;		/* I-RAM */
> +	struct qe_ic_regs __iomem ic;		/* Interrupt Controller */
> +	struct cp_qe __iomem	cp;		/* Communications Processor */
> +	struct qe_mux __iomem	qmx;		/* QE Multiplexer */
> +	struct qe_timers __iomem qet;		/* QE Timers */
> +	struct spi __iomem	spi[0x2];	/* spi */
> +	struct mcc __iomem	mcc;		/* mcc */
> +	struct qe_brg __iomem	brg;		/* brg */
> +	struct usb_ctlr __iomem	usb;		/* USB */
> +	struct si1 __iomem	si1;		/* SI */

Why not just set __iomem on qe_immap references?

-Scott
