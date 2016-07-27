Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzyBp1htqzDrWy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:32:50 +1000 (AEST)
In-Reply-To: <20160520044134.62712b79@kryten>
To: Unknown sender due to SPF <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: Improve comment explaining why we modify VRSAVE
Message-Id: <3rzyBn6cRdz9t2T@ozlabs.org>
Date: Thu, 28 Jul 2016 00:32:49 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-19-05 at 18:41:34 UTC, Unknown sender due to SPF wrote:
> The comment explaining why we modify VRSAVE is misleading, glibc
> does rely on the behaviour. Update the comment.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dd57023747e33572b31867f890

cheers
