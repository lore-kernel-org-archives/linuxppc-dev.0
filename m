Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzh0YBBzDvk4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:20 +1100 (AEDT)
In-Reply-To: <20160811003240.19748-1-jack@codezen.org>
To: Jack Miller <jack@codezen.org>, stewart@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2] powernv: Simplify searching for compatible device nodes
Message-Id: <3tHTzg6HPTz9t2N@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-11-08 at 00:32:40 UTC, Jack Miller wrote:
> This condenses the opal node searching into a single function that finds
> all compatible nodes, instead of just searching the ibm,opal children,
> for ipmi, flash, and prd similar to how opal-i2c nodes are found.
> 
> Signed-off-by: Jack Miller <jack@codezen.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9e4f51bdaf880208869aa001ee94a4

cheers
