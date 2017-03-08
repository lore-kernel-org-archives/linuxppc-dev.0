Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdQ6r0H6LzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 18:25:56 +1100 (AEDT)
In-Reply-To: <1488261828-19696-1-git-send-email-sjitindarsingh@gmail.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, paulus@samba.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>, sam.bobroff@au1.ibm.com
Subject: Re: [V3,1/2] powerpc: Parse the command line before calling CAS
Message-Id: <3vdQ6q3wvNz9sN9@ozlabs.org>
Date: Wed,  8 Mar 2017 18:25:55 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-02-28 at 06:03:47 UTC, Suraj Jitindar Singh wrote:
> On POWER9 the hypervisor requires the guest to decide whether it would
> like to use a hash or radix mmu model at the time it calls
> ibm,client-architecture-support (CAS) based on what the hypervisor has
> said it's allowed to do. It is possible to disable radix by passing
> "disable_radix" on the command line. The next patch will add support for
> the new CAS format, thus we need to parse the command line before calling
> CAS so we can correctly select which mmu we would like to use.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/12cc9fd6b2d8ee307a735b3b9faed0

cheers
