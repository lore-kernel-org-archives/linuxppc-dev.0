Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5C2B2B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 06:48:06 +1100 (EST)
Subject: Re: [PATCH v2] powerpc/dts: fix the compatible string of sec 4.0
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1331097606-22407-1-git-send-email-Shengzhou.Liu@freescale.com>
Date: Fri, 16 Mar 2012 14:47:58 -0500
Message-Id: <03877176-FE39-40F0-867E-FB9F3FA774F5@kernel.crashing.org>
References: <1331097606-22407-1-git-send-email-Shengzhou.Liu@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, stable@kernel.org,
 Liu Shuo <shuo.liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 6, 2012, at 11:20 PM, Shengzhou Liu wrote:

> From: Liu Shuo <shuo.liu@freescale.com>
> 
> Fix the compatible string of sec 4.0 to match with CAMM driver according
> to Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> 
> Signed-off-by: Liu Shuo <shuo.liu@freescale.com>
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> v2: refine description.
> 
> arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi |   10 +++++-----
> 1 files changed, 5 insertions(+), 5 deletions(-)

applied, fixed the type CAMM -> CAAM

- k
