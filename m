Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wSTfz3vkZzDqZQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 May 2017 19:34:35 +1000 (AEST)
In-Reply-To: <20170508071627.21851-2-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Gustavo Bueno Romero <gromero@br.ibm.com>, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org, cyrilbur@gmail.com,
 Breno Leitao <brenohl@br.ibm.com>
Subject: Re: [2/2] selftests/powerpc: Test TM and VMX register state
Message-Id: <3wSTfz3M5lz9s7f@ozlabs.org>
Date: Wed, 17 May 2017 19:34:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-08 at 07:16:27 UTC, Michael Neuling wrote:
> Test that the VMX checkpointed register state is maintained when a VMX
> unavailable exception is taken during a transaction.
> 
> Thanks to Breno Leitao <brenohl@br.ibm.com> and
> Gustavo Bueno Romero <gromero@br.ibm.com> for the original test this
> is based heavily on.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/cde97f8492ac4425c4d0647a308e15

cheers
