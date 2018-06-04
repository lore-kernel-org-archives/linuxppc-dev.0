Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxfn3hY2zF0dT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:10:41 +1000 (AEST)
In-Reply-To: <20180424041559.32410-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: msuchanek@suse.de, linux-kernel@vger.kernel.org, npiggin@gmail.com
Subject: Re: [1/6] powerpc/64s: Add barrier_nospec
Message-Id: <40zxfm40PKz9s0w@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:39 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-24 at 04:15:54 UTC, Michael Ellerman wrote:
> From: Michal Suchanek <msuchanek@suse.de>
> 
> A no-op form of ori (or immediate of 0 into r31 and the result stored
> in r31) has been re-tasked as a speculation barrier. The instruction
> only acts as a barrier on newer machines with appropriate firmware
> support. On older CPUs it remains a harmless no-op.
> 
> Implement barrier_nospec using this instruction.
> 
> mpe: The semantics of the instruction are believed to be that it
> prevents execution of subsequent instructions until preceding branches
> have been fully resolved and are no longer executing speculatively.
> There is no further documentation available at this time.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/a6b3964ad71a61bb7c61d80a60bea7

cheers
