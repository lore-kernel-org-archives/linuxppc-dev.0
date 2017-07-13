Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7bDJ5mLvzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 22:46:40 +1000 (AEST)
In-Reply-To: <20170614234639.11997-2-anton@ozlabs.org>
To: Anton Blanchard <anton@ozlabs.org>, benh@kernel.crashing.org,
 paulus@samba.org, ravi.bangoria@linux.vnet.ibm.com, npiggin@gmail.com,
 naveen.n.rao@linux.vnet.ibm.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [2/2] powerpc: Fix emulation of mfocrf in emulate_step()
Message-Id: <3x7bDJ4sDVz9s65@ozlabs.org>
Date: Thu, 13 Jul 2017 22:46:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-14 at 23:46:39 UTC, Anton Blanchard wrote:
> From: Anton Blanchard <anton@samba.org>
> 
> >From POWER4 onwards, mfocrf() only places the specified CR field into
> the destination GPR, and the rest of it is set to 0. The PowerPC AS
> from version 3.0 now requires this behaviour.
> 
> The emulation code currently puts the entire CR into the destination GPR.
> Fix it.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/64e756c55aa46fc18fd53e8f3598b7

cheers
