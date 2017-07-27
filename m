Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xJGH93vC9zDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 01:34:13 +1000 (AEST)
Date: Thu, 27 Jul 2017 17:27:31 +0200
From: Simon Horman <horms@verge.net.au>
To: Rob Herring <robh@kernel.org>
Cc: arm@kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Scott Wood <oss@buserror.net>,
 Qiang Zhao <qiang.zhao@nxp.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Javier Martinez Canillas <javier@osg.samsung.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] soc: Convert to using %pOF instead of full_name
Message-ID: <20170727152730.GL16143@verge.net.au>
References: <20170718214339.7774-49-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170718214339.7774-49-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 18, 2017 at 04:43:29PM -0500, Rob Herring wrote:
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
>  drivers/soc/fsl/qbman/bman_ccsr.c    | 10 +++++-----
>  drivers/soc/fsl/qbman/bman_portal.c  |  8 +++-----
>  drivers/soc/fsl/qbman/qman_ccsr.c    | 12 ++++++------
>  drivers/soc/fsl/qbman/qman_portal.c  | 11 ++++-------
>  drivers/soc/fsl/qe/gpio.c            |  4 ++--
>  drivers/soc/mediatek/mtk-pmic-wrap.c |  4 ++--
>  drivers/soc/renesas/rcar-rst.c       |  4 ++--
>  drivers/soc/renesas/rcar-sysc.c      |  6 +++---
>  drivers/soc/samsung/pm_domains.c     |  8 ++++----
>  9 files changed, 31 insertions(+), 36 deletions(-)

Renesas portions:

Acked-by: Simon Horman <horms+renesas@verge.net.au>
