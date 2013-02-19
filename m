Return-Path: <STFD002@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0A1E52C029E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 21:04:36 +1100 (EST)
Message-ID: <51234E27.9020604@freescale.com>
Date: Tue, 19 Feb 2013 12:04:23 +0200
From: Diana Craciun <diana.craciun@freescale.com>
MIME-Version: 1.0
To: Varun Sethi <Varun.Sethi@freescale.com>
Subject: Re: [PATCH 6/6 v8] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
References: <1361191939-21260-1-git-send-email-Varun.Sethi@freescale.com>
 <1361191939-21260-7-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1361191939-21260-7-git-send-email-Varun.Sethi@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: joro@8bytes.org, stuart.yoder@freescale.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/18/2013 02:52 PM, Varun Sethi wrote:
> +
> +#define PAACE_TCEF_FORMAT0_8B   0x00
> +#define PAACE_TCEF_FORMAT1_RSVD 0x01
> +
> +#define PAACE_NUMBER_ENTRIES    0x1FF

Where is this number coming from?

Diana
