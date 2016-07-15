Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrTvH0XmfzDqyf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 20:53:31 +1000 (AEST)
In-Reply-To: <1467695057-12431-19-git-send-email-benh@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [18/41] powerpc/rtas: Don't test for machine type in
 rtas_initialize()
Message-Id: <3rrTvG19nhz9s9Y@ozlabs.org>
Date: Fri, 15 Jul 2016 20:53:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-05-07 at 05:03:54 UTC, Benjamin Herrenschmidt wrote:
> The test is unnecessary, the FW_FEATURE_LPAR is sufficient as there
> exist no other LPAR type that has RTAS.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/484cc1ed3c6b90459f02977f6f

cheers
