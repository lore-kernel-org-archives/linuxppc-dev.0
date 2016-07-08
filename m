Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rmFyG4QqHzDqlj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 23:41:26 +1000 (AEST)
In-Reply-To: <564720c5328edd53c9d56db325be7215440eec3e.1467837322.git.jbaron@akamai.com>
To: jbaron@akamai.com, akpm@linux-foundation.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, joe@perches.com,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [v3,
 1/7] powerpc: add explicit #include <asm/asm-compat.h> for jump label
Message-Id: <3rmFyG3J7pz9t0P@ozlabs.org>
Date: Fri,  8 Jul 2016 23:41:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-06-07 at 21:42:30 UTC, jbaron@akamai.com wrote:
> The stringify_in_c() macro may not be included. Make the dependency
> explicit.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Jason Baron <jbaron@akamai.com>

I didn't test it, but assuming you did:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
