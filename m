Return-Path: <matthias.bgg@gmail.com>
Received: from mail-wr0-x242.google.com (mail-wr0-x242.google.com
 [IPv6:2a00:1450:400c:c0c::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCD4m68JqzDrVC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 20:37:44 +1000 (AEST)
Received: by mail-wr0-x242.google.com with SMTP id 12so58841wrb.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 03:37:44 -0700 (PDT)
Subject: Re: [PATCH] soc: Convert to using %pOF instead of full_name
To: Rob Herring <robh@kernel.org>, arm@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Scott Wood <oss@buserror.net>, Qiang Zhao <qiang.zhao@nxp.com>,
 Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
References: <20170718214339.7774-49-robh@kernel.org>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6e936e3c-0e46-4f06-5571-5942d6fb1778@gmail.com>
Date: Wed, 19 Jul 2017 12:37:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170718214339.7774-49-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07/18/2017 11:43 PM, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Qiang Zhao <qiang.zhao@nxp.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-samsung-soc@vger.kernel.org
> ---
>   drivers/soc/fsl/qbman/bman_ccsr.c    | 10 +++++-----
>   drivers/soc/fsl/qbman/bman_portal.c  |  8 +++-----
>   drivers/soc/fsl/qbman/qman_ccsr.c    | 12 ++++++------
>   drivers/soc/fsl/qbman/qman_portal.c  | 11 ++++-------
>   drivers/soc/fsl/qe/gpio.c            |  4 ++--
>   drivers/soc/mediatek/mtk-pmic-wrap.c |  4 ++--

For Mediatek:

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
