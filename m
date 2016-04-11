Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qk8fL5hXQzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 22:35:06 +1000 (AEST)
In-Reply-To: <56BB6F14.9020708@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [1/3] powerpc/pseries: Refactor dlpar_add_lmb() code
Message-Id: <3qk8fL4mNzz9t42@ozlabs.org>
Date: Mon, 11 Apr 2016 22:35:06 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-10-02 at 17:10:44 UTC, Nathan Fontenot wrote:
> Re-factor dlpar_lmb_add() routine by moving the validation of the lmb
> flags and the acquireing of the DRC to a wrapper around the work to add
> the memory to the system. This is done to make handling of errors
> during the addition of the memory easier and to facilitate the upcoming
> addition of updating the lmb's affinity prior to adding the memory.
> 
> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4a4bdfea7cb75b5c8b22293279

cheers
