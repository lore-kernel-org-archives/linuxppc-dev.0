Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlyy19q8zDr64
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:18 +1100 (AEDT)
In-Reply-To: <1508386099-2126-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc/64: Free up CPU_FTR_ICSWX
Message-Id: <3yWlyx4qhCz9sPs@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-19 at 04:08:19 UTC, Michael Ellerman wrote:
> The last user of CPU_FTR_ICSWX was removed in commit
> 6ff4d3e96652 ("powerpc: Remove old unused icswx based coprocessor
> support"), so free the bit up for future use.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/c1807e3f84668c4c1e838386fdc3f6

cheers
