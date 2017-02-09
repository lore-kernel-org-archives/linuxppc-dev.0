Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJzCN3GNszDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 00:17:52 +1100 (AEDT)
In-Reply-To: <f0e5117608ea57a64ed60562ec29203a46234b64.1483055859.git.fthain@telegraphics.com.au>
To: Finn Thain <fthain@telegraphics.com.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND,01/10] via-cuda: Cleanup printk calls
Message-Id: <3vJzCN2hnJz9s7K@ozlabs.org>
Date: Fri, 10 Feb 2017 00:17:52 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2017-01-01 at 00:56:26 UTC, Finn Thain wrote:
> Add missing log message severity, remove old debug messages and
> replace printk() loop with print_hex_dump() call.
> 
> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/523717d1496c794e8380d0e3de5ca6

cheers
