Return-Path: <STFD002@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 46E9C2C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2013 02:59:52 +1100 (EST)
Message-ID: <5123A169.9060100@freescale.com>
Date: Tue, 19 Feb 2013 17:59:37 +0200
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
> +/**
> + * pamu_get_ppaace() - Return the primary PACCE
> + * @liodn: liodn PAACT index for desired PAACE
> + *
> + * Returns the ppace pointer upon success else return
> + * null.
> + */
> +static struct paace *pamu_get_ppaace(int liodn)
> +{
> +	if (!ppaact || liodn > PAACE_NUMBER_ENTRIES) {

Shouldn't be "liodn >= PAACE_NUMBER_ENTRIES" ?

> +		pr_err("PPAACT doesn't exist\n");
> +		return NULL;
> +	}
> +
> +	return &ppaact[liodn];
> +}
> +

Diana
