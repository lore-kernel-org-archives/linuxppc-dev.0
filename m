Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzNHy63JtzDqJt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 23:06:06 +1000 (AEST)
In-Reply-To: <1491213104-24450-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: devicetree@vger.kernel.org, Alistair Popple <alistair@popple.id.au>,
 mhairgrove@nvidia.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 robh+dt@kernel.org, shailendras@nvidia.com
Subject: Re: [v2,1/3] drivers/of/base.c: Add of_property_read_u64_index
Message-Id: <3vzNHy3Nw9z9sDB@ozlabs.org>
Date: Thu,  6 Apr 2017 23:06:06 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-03 at 09:51:42 UTC, Alistair Popple wrote:
> There is of_property_read_u32_index but no u64 variant. This patch
> adds one similar to the u32 version for u64.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2475a2b6c877a0c8d1ca42c3f2b30f

cheers
