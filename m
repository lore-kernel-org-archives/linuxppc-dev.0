Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 086571A0935
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 19:27:03 +1000 (AEST)
In-Reply-To: <1435613439.9587.56.camel@perches.com>
To: Joe Perches <joe@perches.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc: Remove redundant breaks
Message-Id: <20150810092702.B8A661401F6@ozlabs.org>
Date: Mon, 10 Aug 2015 19:27:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-29-06 at 21:30:39 UTC, Joe Perches wrote:
> break; break; isn't useful.
> 
> Remove one.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a825ac078b50266fb091

cheers
