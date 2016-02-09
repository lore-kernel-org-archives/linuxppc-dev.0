Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D09A01A0331
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 23:16:07 +1100 (AEDT)
In-Reply-To: <87bn7vm1pg.fsf@linux-m68k.org>
To: Andreas Schwab <schwab@linux-m68k.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: powerpc: fix dedotify for binutils >= 2.26
Message-Id: <20160209121607.9FFE71401CD@ozlabs.org>
Date: Tue,  9 Feb 2016 23:16:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-05-02 at 18:50:03 UTC, Andreas Schwab wrote:
> Since binutils 2.26 BFD is doing suffix merging on STRTAB sections.  But
> dedotify modifies the symbol names in place, which can also modify
> unrelated symbols with a name that matches a suffix of a dotted name.  To
> remove the leading dot of a symbol name we can just increment the pointer
> into the STRTAB section instead.
> 
> Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/f15838e9cac8f78f0cc506529b

cheers
