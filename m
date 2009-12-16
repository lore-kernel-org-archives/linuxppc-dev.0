Return-Path: <R1AAHA@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8698AB6F0A
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 09:36:56 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	nBGMarJ0025544
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 15:36:53 -0700 (MST)
Received: from az33exm22.fsl.freescale.net (az33exm22.am.freescale.net
	[10.64.32.10])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id nBGMfGmh010185
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 16:41:16 -0600 (CST)
Date: Wed, 16 Dec 2009 16:41:44 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Vishnu Suresh <Vishnu@freescale.com>
Subject: Re: [PATCH v2 2/2] Crypto: Talitos: Support for Async_tx XOR offload
Message-Id: <20091216164144.daff5468.kim.phillips@freescale.com>
In-Reply-To: <1260977698-4076-1-git-send-email-Vishnu@freescale.com>
References: <1260977698-4076-1-git-send-email-Vishnu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: herbert@gondor.apana.org.au, B04825@freescale.com,
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-crypto@vger.kernel.org,
	Dipen Dudhat <Dipen.Dudhat@freescale.com>, dan.j.williams@intel.com,
	Maneesh Gupta <Maneesh.Gupta@freescale.com>, R58472@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 16 Dec 2009 21:04:58 +0530
Vishnu Suresh <Vishnu@freescale.com> wrote:

> Expose Talitos's XOR functionality to be used for
> RAID Parity calculation via the Async_tx layer.
> 
> Known Issue:
> When used with fsldma, random crashes are observed
> on some platforms. Hence, inter-operability with fsldma
> is currently disabled
> 
> Thanks to Surender Kumar and Lee Nipper for their help in
> realising this driver
> 
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> Signed-off-by: Dipen Dudhat <Dipen.Dudhat@freescale.com>
> Signed-off-by: Maneesh Gupta <Maneesh.Gupta@freescale.com>
> Signed-off-by: Vishnu Suresh <Vishnu@freescale.com>
> ---
> Changes with respect to v1 as per comments received
> o. Rebased to linux-next as of 20091216
> o. The selection is based exclusive of fsldma
> o. Intoduced a new Kernel Configuration variable
>    *. This enables selecting the Cryptographic functionality
>       of Talitos along with fsldma.
>    *. Disables the XOR parity calculation offload, if fsldma enabled
>       either as kernel in-built or as a module
>    *. Once the inter-operability with fsldma is resolved, this option
>       can be removed

wait, why can't the interoperability bug be fixed in the first place?

Kim
