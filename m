Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WNpc2hDLzDqDQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:07:36 +1000 (AEST)
In-Reply-To: <20180619205230.19290-1-aaro.koskinen@iki.fi>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: powerpc: enable kernel XZ compression option on BOOK3S_32
Message-Id: <41WNpc06Dmz9s55@ozlabs.org>
Date: Thu, 19 Jul 2018 16:07:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-06-19 at 20:52:30 UTC, Aaro Koskinen wrote:
> Enable kernel XZ compression option on BOOK3S_32. Tested on G4 PowerBook.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/26064848efbca49c643d1237dc1f82

cheers
