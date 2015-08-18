Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA2DD1A0239
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 20:43:30 +1000 (AEST)
In-Reply-To: <1437971974-2434-2-git-send-email-dave.long@linaro.org>
To: "David A. Long" <dave.long@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [v2,
 1/2] Move the pt_regs_offset struct definition from arch to common
 include file
Message-Id: <20150818104330.B24DC14032B@ozlabs.org>
Date: Tue, 18 Aug 2015 20:43:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-27-07 at 04:39:33 UTC, "David A. Long" wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> The pt_regs_offset structure is used for the HAVE_REGS_AND_STACK_ACCESS_API
> feature and has identical definitions in four different arch ptrace.h
> include files. It seems unlikely that definition would ever need to be
> changed regardless of architecture so lets move it into
> include/linux/ptrace.h, along with macros commonly used to access it.

Thanks for cleaning this up. Tested successfully on powerpc.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
