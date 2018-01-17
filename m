Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM7JH5RsqzF0XV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jan 2018 00:30:39 +1100 (AEDT)
In-Reply-To: <bb30d80cc985d7307fa1286c9e6824230698919b.1515759812.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [1/8] powerpc/8xx: Remove CPU6 ERRATA Workaround
Message-Id: <3zM7JF6vWyz9sRW@ozlabs.org>
Date: Thu, 18 Jan 2018 00:30:35 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-01-12 at 12:45:19 UTC, Christophe Leroy wrote:
> CPU6 ERRATA affects only MPC860 revisions prior to C.0. Manufacturing
> of those revisiosn was stopped in 1999-2000.
> Therefore, it has been almost 20 years since this ERRATA has been
> fixed in the silicon.
> 
> This patch removes the workaround for that ERRATA.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/2a45addd21de25f41c8f21a6f08f09

cheers
