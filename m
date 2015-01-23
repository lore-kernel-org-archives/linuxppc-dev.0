Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE55D1A0C7F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2015 14:06:32 +1100 (AEDT)
Message-ID: <1421982392.24984.9.camel@ellerman.id.au>
Subject: Re: [PATCH v2 1/2] powerpc: Add helpers for LPCR PECE1 operations
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Date: Fri, 23 Jan 2015 14:06:32 +1100
In-Reply-To: <1421654727-31656-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1421654727-31656-1-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-01-19 at 13:35 +0530, Shreyas B. Prabhu wrote:
> PECE1 bit in LPCR is used to control whether decrementer can cause exit
> from powersaving states. PECE1 bit is cleared before entering fastsleep
> or deeper powersaving state and it is set on waking up. Since both
> cpuidle and cpu offline operations use these powersaving states, add
> helper functions to be used in both these places.

Thanks.

That isn't really much clearer than the original, so in the end I just merged
your original fix.

I'll think if there's a bigger consolidation we can do that makes it clearer.

cheers
