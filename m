Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5C5C22C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jul 2012 01:58:10 +1000 (EST)
Message-ID: <4FFC50FF.707@freescale.com>
Date: Tue, 10 Jul 2012 10:57:51 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Xu Jiucheng <Jiucheng.Xu@freescale.com>
Subject: Re: [PATCH 2/2] powerpc/85xx: Create dts of each core in CAMP mode
 for P1021RDB-PC
References: <1341909561-6591-1-git-send-email-Jiucheng.Xu@freescale.com>
 <1341909561-6591-2-git-send-email-Jiucheng.Xu@freescale.com>
In-Reply-To: <1341909561-6591-2-git-send-email-Jiucheng.Xu@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2012 03:39 AM, Xu Jiucheng wrote:
> +		crypto@30000 {
> +                        status = "disabled";
> +                };

Whitespace.

> +
> +		mpic: pic@40000 {
> +			protected-sources = <
> +			16 		/* ecm, mem, L2, pci0, pci1 */
> +			43 42 59	/* i2c, serial0, spi */
> +			47 63 62 	/* gpio, tdm */
> +			20 21 22 23	/* dma */
> +			03 02 		/* mdio */
> +			29 30 34	/* enet0-queue-group0 */
> +			17 18 24	/* enet0-queue-group1 */
> +			35 36 40	/* enet1-queue-group0 */
> +			51 52 67	/* enet1-queue-group1 */
> +			28 72 45 58 	/* usb, sdhci, crypto */
> +			0xb0 0xb1 0xb2	/* message */
> +			0xb3 0xb4 0xb5
> +			0xb6 0xb7
> +			0xe0 0xe1 0xe2	/* msi */
> +			0xe3 0xe4 0xe5
> +			0xe6 0xe7		/* sdhci, crypto , pci */
> +			>;
> +			pic-no-reset;
> +		};

Besides what Timur said, do we really need protected-sources now that we
have pic-no-reset?

-Scott
