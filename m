Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltwp5mJHzDqhV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:26:18 +1000 (AEST)
In-Reply-To: <20180726130717.18761-2-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, anton@samba.org, npiggin@gmail.com
Subject: Re: [01/16] powerpc/64s: Move SET_SCRATCH0() into
 EXCEPTION_PROLOG_PSERIES()
Message-Id: <41ltwl1LHXz9s8W@ozlabs.org>
Date: Thu,  9 Aug 2018 00:26:07 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-07-26 at 13:07:02 UTC, Michael Ellerman wrote:
> EXCEPTION_PROLOG_PSERIES() only has two users, STD_EXCEPTION_PSERIES()
> and STD_EXCEPTION_HV() both of which "call" SET_SCRATCH0(), so just
> move SET_SCRATCH0() into EXCEPTION_PROLOG_PSERIES().
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/4a7a0a8444ba4cebb3a6744e9c14fc

cheers
