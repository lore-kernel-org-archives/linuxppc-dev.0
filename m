Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45EDD1A0394
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 22:27:10 +1100 (AEDT)
In-Reply-To: <1448330741-4804-3-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>
Subject: Re: [3/4] selftests/powerpc: Move TM helpers into tm.h
Message-Id: <20151215112709.BB80614032F@ozlabs.org>
Date: Tue, 15 Dec 2015 22:27:09 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-24-11 at 02:05:40 UTC, Michael Ellerman wrote:
> Move have_htm_nosc() into a new tm.h, and add a new helper, have_htm()
> which we'll use in the next patch.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/34dc8b279dc5dd3ce8632980

cheers
