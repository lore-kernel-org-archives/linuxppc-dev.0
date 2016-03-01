Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 68F2E1A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 09:21:19 +1100 (AEDT)
In-Reply-To: <1454970427-23017-2-git-send-email-luis.henriques@canonical.com>
To: Luis Henriques <luis.henriques@canonical.com>,
 Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Joe Perches <joe@perches.com>, linuxppc-dev@lists.ozlabs.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [v2, 1/4] powerpc/ps3: gelic_udbg: use struct ethhdr from
 <linux/if_ether.h>
Message-Id: <20160301222119.4D99E140273@ozlabs.org>
Date: Wed,  2 Mar 2016 09:21:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-08-02 at 22:27:04 UTC, Luis Henriques wrote:
> Instead of defining a local version of struct ethhdr use the standard
> definition from <linux/if_ether.h>.
> 
> The fields in the <linux/if_ether.h> definition have different names:
>  - dest -> h_dest
>  - src -> h_source
>  - type -> h_proto
> 
> While there, use a few other standard functions/macros:
>  - eth_broadcast_addr (instead of a memset)
>  - ETH_ALEN
>  - ETH_P_8021Q
> 
> Signed-off-by: Luis Henriques <luis.henriques@canonical.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/497abcf6afe2d85f047fbf1373

cheers
