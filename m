Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdP2R0YSPzDrJY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 22:37:35 +1000 (AEST)
In-Reply-To: <20170821151651.25096-4-robh@kernel.org>
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: David Laight <David.Laight@aculab.com>,
 Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [v2,
 3/5] powerpc: pseries: remove dlpar_attach_node dependency on full
 path
Message-Id: <3xdP2Q710hz9sR9@ozlabs.org>
Date: Thu, 24 Aug 2017 22:37:34 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-21 at 15:16:49 UTC, Rob Herring wrote:
> In preparation to stop storing the full node path in full_name, remove the
> dependency on full_name from dlpar_attach_node(). Callers of
> dlpar_attach_node() already have the parent device_node, so just pass the
> parent node into dlpar_attach_node instead of the path. This avoids doing
> a lookup of the parent node by the path.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/215ee763f8cb9a2912d411f96f6f67

cheers
