Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6MMG5bjBzDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 22:48:26 +1000 (AEST)
In-Reply-To: <20170706084643.22425-1-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: powerpc/asm: Mark cr0 as clobbered in mftb()
Message-Id: <3x6MMG547Qz9sR8@ozlabs.org>
Date: Tue, 11 Jul 2017 22:48:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-07-06 at 08:46:43 UTC, Oliver O'Halloran wrote:
> The workaround for the CELL timebase bug does not correctly mark cr0 as
> being clobbered. This can result in GCC making some poor^W completely
> broken optimisations.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/2400fd822f467cb4c886c879d8ad99

cheers
