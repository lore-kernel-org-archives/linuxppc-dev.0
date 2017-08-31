Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLF6JG3zDqV5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:05 +1000 (AEST)
In-Reply-To: <20170628114907.kf3t65mrdbq7rsfm@mwanda>
To: Dan Carpenter <dan.carpenter@oracle.com>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc: remapping too much memory
Message-Id: <3xjgLF5Q9Lz9t2W@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-06-28 at 11:49:07 UTC, Dan Carpenter wrote:
> There is a cut and paste error here so we use "sizeof(struct mpc83xx_pmc)"
> to remap the memory for "clock_regs".  That sizeof() is 20 bytes and we
> only need to remap 12 bytes.  It presumably doesn't affect run time too
> much...
> 
> I changed them to both use "sizeof(*variable_name)" because that's the
> prefered kernel style these days.
> 
> Fixes: d49747bdfb2d ("powerpc/mpc83xx: Power Management support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/c65540453e150844367ffe98e45d51

cheers
