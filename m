Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTvV14y5zDqyg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:42 +1000 (AEST)
In-Reply-To: <1468284892-27765-5-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: arnd@arndb.de, Daniel Axtens <dja@axtens.net>
Subject: Re: [v2,5/5] powerpc/sparse: Make ppc_md.{halt, restart} __noreturn
Message-Id: <3rrTvT4QDSz9s3v@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-07 at 00:54:52 UTC, Daniel Axtens wrote:
> PowerNV marks it's halt and restart calls as __noreturn. However,
> ppc_md does not have this annotation. Add the annotation to ppc_md,
> and then to every halt/restart function that is missing it.
> 
> Additionally, I have verified that all of these functions do not
> return. Occasionally I have added a spin loop to be sure.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/95ec77c06e8e63fff50c497eca

cheers
