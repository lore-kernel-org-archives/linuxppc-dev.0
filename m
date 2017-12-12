Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ywyXh1J8HzDrVZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Dec 2017 22:39:32 +1100 (AEDT)
In-Reply-To: <20171201155827.57979-1-ivan@de.ibm.com>
To: Ivan Mikhaylov <ivan@de.ibm.com>, Alistair Popple <alistair@popple.id.au>,
 Matt Porter <mporter@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2,1/4] 44x/fsp2: add fsp2 headers
Message-Id: <3ywyXg5x03z9t9s@ozlabs.org>
Date: Tue, 12 Dec 2017 22:39:31 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-12-01 at 15:58:24 UTC, Ivan Mikhaylov wrote:
> add cmu, plbX, l2, ddr3/4, crcs register definitions.
> add mfcmu, mtcmu functions for indirect access to cmu.
> add mtl2, mfl2 same for l2 cache core reg set.
> 
> Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/494d82ceae7f3b9fdb5154b4469e5b

cheers
