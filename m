Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41m6Mx46tYzDqw8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 09:02:05 +1000 (AEST)
Date: Wed, 8 Aug 2018 18:01:52 -0500
From: Scott Wood <oss@buserror.net>
To: Ran Wang <ran.wang_1@nxp.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Kumar Gala <galak@kernel.crashing.org>,
 Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
 Zhao Chenhui <chenhui.zhao@freescale.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Message-ID: <20180808230152.GA5459@home.buserror.net>
References: <20180411063551.30368-1-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180411063551.30368-1-ran.wang_1@nxp.com>
Subject: Re: [v2, 1/6] powerpc/pm: Fix suspend=n in menuconfig for e500mc
 platforms.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 11, 2018 at 02:35:46PM +0800, Ran Wang wrote:
> Also, unselect FSL_PMC which is for older platfroms instead.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v2:
>   - no change
> 
>  arch/powerpc/Kconfig |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

It's not "fixing" anything, but rather enabling something that was
previously unsupported -- and that should happen after the code that
adds support.

-Scott
