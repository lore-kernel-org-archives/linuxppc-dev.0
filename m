Return-Path: <R58495@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6707F2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Sep 2013 09:40:31 +1000 (EST)
Message-ID: <523796E4.2060207@freescale.com>
Date: Mon, 16 Sep 2013 16:40:20 -0700
From: York Sun <yorksun@freescale.com>
MIME-Version: 1.0
To: <galak@kernel.crashing.org>
Subject: Re: [linuxppc-release] [Patch v2] powerpc/corenet64_smp_defconfig:
 Enable most SPI splash
References: <1379374541-13838-1-git-send-email-yorksun@freescale.com>
In-Reply-To: <1379374541-13838-1-git-send-email-yorksun@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/16/2013 04:35 PM, York Sun wrote:
> Enable CONFIG_MTD_M25P80 for corenet64_smp_defconfig. Verified on
> P5040DS.
> 
> Signed-off-by: York Sun <yorksun@freescale.com>
> ---
> Change log:
>  v2: remote reviewed-by and tested-by lines added by gerrit
> 

Pardon my typo. I meant to type "remove", instead of "remote".

York
