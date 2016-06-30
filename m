Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgJvH0dRLzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 22:36:43 +1000 (AEST)
In-Reply-To: <1467025661-1410-1-git-send-email-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Jiri Kosina <trivial@kernel.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [V2] powerpc/fadump: trivial fix of spelling mistake,
 clean up message
Message-Id: <3rgJvG66b3z9t0t@ozlabs.org>
Date: Thu, 30 Jun 2016 22:36:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-27-06 at 11:07:41 UTC, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Fix trivial spelling mistake "rgistration". Also use pr_err
> instead of printk and unsplit the string to keep it all on one
> line.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4a03749f140cbee6fee66b674b

cheers
