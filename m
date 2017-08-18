Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xYjcc5YdHzDr4X
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Aug 2017 22:50:56 +1000 (AEST)
In-Reply-To: <d6a1a353de6a87bb5474ca9f1c1ff7ab2c4a1eb4.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Matthew Wilcox <willy@infradead.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
Subject: Re: [1/2] powerpc: string: implement optimized memset variants
Message-Id: <3xYjcc4yVMz9t3m@ozlabs.org>
Date: Fri, 18 Aug 2017 22:50:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-27 at 19:37:40 UTC, "Naveen N. Rao" wrote:
> Based on Matthew Wilcox's patches for other architectures.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/694fc88ce271fd48f7939c032c1247

cheers
