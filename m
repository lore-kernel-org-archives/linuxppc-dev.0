Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F36E1A08D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 14:25:32 +1000 (AEST)
Message-ID: <1438143932.17434.1.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: Don't ignore add_process_element result when
 attaching context
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com
Date: Wed, 29 Jul 2015 14:25:32 +1000
In-Reply-To: <1438142842-31603-1-git-send-email-dja@axtens.net>
References: <1438142842-31603-1-git-send-email-dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-07-29 at 14:07 +1000, Daniel Axtens wrote:
> Previously, when attaching a context in dedicated mode, we ignored

Previously? You mean currently? Now is before this patch is applied.

> the result of add_process_element, which could potentially fail.
> 
> If add_process_element returns and error, pass it back to the caller.
                                   ^

I can fix.

> Signed-off-by: Daniel Axtens <dja@axtens.net>
> 
> ---
> 
> I'm not sure if this is worth sending to stable: it doesn't fix
> any actual bug, it just lets us know earlier if we've failed.
> 
> However, if mpe, Mikey or Ian feel like it should go to stable I
> have no objection to that either.

stable_kernel_rules.txt says:

 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing).


So I think not. But rules are flexible so I can be convinced otherwise if
anyone has a good argument.

cheers
