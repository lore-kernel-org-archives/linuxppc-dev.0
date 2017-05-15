Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wR7pw43sTzDqLN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 May 2017 15:06:48 +1000 (AEST)
In-Reply-To: <1494337472-23419-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: [1/3] of/fdt: introduce of_scan_flat_dt_subnodes and
 of_get_flat_dt_phandle
Message-Id: <3wR7pv62jpz9sCX@ozlabs.org>
Date: Mon, 15 May 2017 15:06:47 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-05-09 at 13:44:30 UTC, Michael Ellerman wrote:
> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Introduce primitives for FDT parsing. These will be used for powerpc
> cpufeatures node scanning, which has quite complex structure but should
> be processed early.
> 
> Cc: devicetree@vger.kernel.org
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/ea47dd191d543f81e0912b5dc0471b

cheers
