Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 515281A0D94
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jan 2015 16:19:23 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0105.outbound.protection.outlook.com [157.56.111.105])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 953771402AE
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2015 16:19:22 +1100 (AEDT)
Date: Thu, 29 Jan 2015 23:03:18 -0600
From: Scott Wood <scottwood@freescale.com>
To: Emil Medve <Emilian.Medve@freescale.com>
Subject: Re: [v5, 5/6] powerpc/mpc85xx: Add FSL QorIQ DPAA BMan support to
 device tree(s)
Message-ID: <20150130050318.GA12890@home.buserror.net>
References: <1418034561-12034-6-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1418034561-12034-6-git-send-email-Emilian.Medve@Freescale.com>
Cc: linuxppc-dev@ozlabs.org, Geoff Thorpe <Geoff.Thorpe@Freescale.com>,
 Chunhe Lan <Chunhe.Lan@Freescale.com>,
 Poonam Aggrwal <poonam.aggrwal@Freescale.com>, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 08, 2014 at 04:29:20AM -0600, Emil Medve wrote:
> From: Kumar Gala <galak@kernel.crashing.org>
> 
> Change-Id: If643fa5ba0a903aef8f5056a2c90ebecc995b760
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Geoff Thorpe <Geoff.Thorpe@freescale.com>
> Signed-off-by: Hai-Ying Wang <Haiying.Wang@freescale.com>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> [Emil Medve: Sync with the upstream binding]
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

Doesn't apply cleanly

> @@ -408,6 +415,8 @@ crypto: crypto@300000 {
>  		fsl,iommu-parent = <&pamu1>;
>  	};
>  
> +/include/ "qoriq-bman1.dtsi"
> +
>  /include/ "qoriq-fman-0.dtsi"
>  /include/ "qoriq-fman-0-1g-0.dtsi"
>  /include/ "qoriq-fman-0-1g-1.dtsi"

What tree did you base these patches on?  There's no fman in the upstream
device trees yet (just a binding).

-Scott
