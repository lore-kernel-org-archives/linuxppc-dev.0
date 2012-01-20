Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 77A26B6F13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jan 2012 07:21:00 +1100 (EST)
Message-ID: <4F19CC8E.6080908@freescale.com>
Date: Fri, 20 Jan 2012 14:20:30 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Subject: Re: [PATCH] mtd/nand:Fix wrong usage of is_blank() in
 fsl_ifc_run_command
References: <1326859991-7469-1-git-send-email-prabhakar@freescale.com>
In-Reply-To: <1326859991-7469-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/17/2012 10:13 PM, Prabhakar Kushwaha wrote:
> +		for (i = sector; i <= sector_end; i++) {
> +			errors = check_read_ecc(mtd, ctrl, eccstat, i);
> +
> +			if (errors == 15) {
> +				/*
> +				 * Uncorrectable error.
> +				 * OK only if the whole page is blank.
> +				 *
> +				 * We disable ECCER reporting due to...

s/due to.../due to/

Otherwise looks good.

-Scott
