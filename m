Return-Path: <R1AAHA@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BDC9DB6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Mar 2012 10:27:58 +1100 (EST)
Date: Wed, 7 Mar 2012 17:26:11 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: Re: [PATCH v2] powerpc/dts: fix the compatible string of sec 4.0
Message-ID: <20120307172611.86985d2c22af2c3213770f35@freescale.com>
In-Reply-To: <1331097606-22407-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1331097606-22407-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
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

On Wed, 7 Mar 2012 13:20:06 +0800
Shengzhou Liu <Shengzhou.Liu@freescale.com> wrote:

> From: Liu Shuo <shuo.liu@freescale.com>
> 
> Fix the compatible string of sec 4.0 to match with CAMM driver according
> to Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> 
> Signed-off-by: Liu Shuo <shuo.liu@freescale.com>
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> v2: refine description.

can we patch the caam driver to still work with "fsl-sec4.0"?

Thanks,

Kim
