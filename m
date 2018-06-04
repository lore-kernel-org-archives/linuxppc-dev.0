Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxg82CcczF0kx
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:00 +1000 (AEST)
In-Reply-To: <20180511080313.29815-1-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/xive: Remove (almost) unused macros
Message-Id: <40zxg45xZYz9s08@ozlabs.org>
Date: Tue,  5 Jun 2018 00:10:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-05-11 at 08:03:13 UTC, Russell Currey wrote:
> The GETFIELD and SETFIELD macros in xive-regs.h aren't used except for a
> single instance of GETFIELD, so replace that and remove them.
> 
> These macros are also defined in vas.h, so either those should be
> eventually replaced or the macros moved into bitops.h.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8a792262f320245de0174e6bcb5513

cheers
