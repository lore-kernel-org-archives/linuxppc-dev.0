Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptdH03GVzF0WL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:14 +1000 (AEST)
In-Reply-To: <20180808115724.gh5mbbi6twzqbqao@kili.mountain>
To: Dan Carpenter <dan.carpenter@oracle.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Jia Hongtao <B38951@freescale.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Rob Herring <robh@kernel.org>, kernel-janitors@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: fix size calculation using resource_size()
Message-Id: <41ptdG50hMz9sCn@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:13 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-08-08 at 11:57:24 UTC, Dan Carpenter wrote:
> The problem is the the calculation should be "end - start + 1" but the
> plus one is missing in this calculation.
> 
> Fixes: 8626816e905e ("powerpc: add support for MPIC message register API")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c42d3be0c06f0c1c416054022aa535

cheers
