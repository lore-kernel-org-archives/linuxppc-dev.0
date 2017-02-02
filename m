Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vDdTk0nhKzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 22:45:14 +1100 (AEDT)
In-Reply-To: <20170130064155.30281-2-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>
Subject: Re: [1/3] powerpc/sparse: constify the address pointer in
 __get_user_check
Message-Id: <3vDdTk0HTPz9s7P@ozlabs.org>
Date: Thu,  2 Feb 2017 22:45:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-01-30 at 06:41:53 UTC, Daniel Axtens wrote:
> In __get_user_check, we create an intermediate pointer for the
> user address we're about to fetch. We currently don't tag this
> pointer as const. Make it const, as we are simply dereferencing
> it, and it's scope is limited to the __get_user_check macro.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f84ed59a612d866cde0bd17ad2a52a

cheers
