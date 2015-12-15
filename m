Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424551A033D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 22:27:06 +1100 (AEDT)
In-Reply-To: <1447992934-18905-2-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, paulus@samba.org,
 sam.bobroff@au1.ibm.com
Subject: Re: [v2,1/3] powerpc: Print MSR TM bits in oops messages
Message-Id: <20151215112706.0880B140323@ozlabs.org>
Date: Tue, 15 Dec 2015 22:27:05 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-20-11 at 04:15:32 UTC, Michael Neuling wrote:
> Print MSR TM bits in oops messages.  This appends them to the end
> like this:
> 
>     MSR: 8000000502823031 <SF,VEC,VSX,FP,ME,IR,DR,LE,TM[TE]>
> 
> You get the TM[] only if at least one TM MSR bit is set.  Inside the
> TM[], E means Enabled (bit 32), S means Suspended (bit 33), and T
> means Transactional (bit 34)
> 
> If no bits are set, you get no TM[] output.
> 
> Include rework of printbits() to handle this case.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/801c0b2c4db3a33d56b3e192

cheers
