Return-Path: <R1AAHA@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BD6DB6FF8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jun 2012 05:36:16 +1000 (EST)
Date: Wed, 27 Jun 2012 14:34:11 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
Subject: Re: [PATCH] Using alloc_coherent for caam job rings
Message-ID: <20120627143411.b33d3ddab40e67b511297dcd@freescale.com>
In-Reply-To: <1340774912-19042-1-git-send-email-bharat.bhushan@freescale.com>
References: <1340774912-19042-1-git-send-email-bharat.bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 27 Jun 2012 10:58:32 +0530
Bharat Bhushan <r65777@freescale.com> wrote:

> This resolves the Linux boot crash issue when "swiotlb=force" is set
> in bootargs on systems which have memory more than 4G.

Acked-by: Kim Phillips <kim.phillips@freescale.com>

Thanks Bharat,

Kim
