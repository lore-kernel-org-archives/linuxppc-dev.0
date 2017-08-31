Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLc2dPyzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:24 +1000 (AEST)
In-Reply-To: <90eacc5c9ff738176330dd53e128c945a88ead9f.1503900231.git.arvind.yadav.cs@gmail.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, agust@denx.de,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/512x: clk: constify clk_div_table
Message-Id: <3xjgLc0Lj9z9t2f@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-28 at 06:05:15 UTC, Arvind Yadav wrote:
> clk_div_table are not supposed to change at runtime.
> mpc512x_clk_divtable function working with const
> clk_div_table. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9e2b70fbbc451cc56863644f6e7349

cheers
