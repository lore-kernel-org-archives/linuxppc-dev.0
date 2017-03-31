Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvgsc6Z6fzDqH7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 23:33:56 +1100 (AEDT)
In-Reply-To: <20170323075401.4371-1-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [v2] powerpc/powernv: de-deuplicate OPAL call wrappers
Message-Id: <3vvgsc1Q9xz9s2x@ozlabs.org>
Date: Fri, 31 Mar 2017 23:33:56 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-03-23 at 07:54:01 UTC, Oliver O'Halloran wrote:
> Currently the code to perform an OPAL call is duplicated between the
> normal path and path taken when tracepoints are enabled. There's no
> real need for this and combining them makes opal_tracepoint_entry
> considerably easier to understand.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c3a08e93d66e9ba59ffbfb610af2f7

cheers
