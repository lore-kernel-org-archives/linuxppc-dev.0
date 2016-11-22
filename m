Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN60r1LFfzDvfJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 11:34:20 +1100 (AEDT)
In-Reply-To: <20161030193557.23862-1-christophe.jaillet@wanadoo.fr>
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>, imunsie@au1.ibm.com,
 fbarrat@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: cxl: Fix memory allocation failure test
Message-Id: <3tN60q61rdz9t17@ozlabs.org>
Date: Tue, 22 Nov 2016 11:34:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2016-10-30 at 19:35:57 UTC, Christophe Jaillet wrote:
> 'cxl_context_alloc()' does not return an error pointer. It is just a
> shortcut for a call to 'kzalloc' with 'sizeof(struct cxl_context)' as the
> size parameter.
> 
> So its return value should be compared with NULL.
> While fixing it, simplify a bit the code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5cd4f5cec2374d2c09299211d2b357

cheers
