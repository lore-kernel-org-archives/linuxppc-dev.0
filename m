Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTRS0G1HzDq5c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:40:52 +1000 (AEST)
In-Reply-To: <1463534212-4879-3-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Daniel Axtens <dja@axtens.net>
Subject: Re: [3/4] powerpc/sparse: Include headers containing prototypes
Message-Id: <3rYTRR13wQz9t0f@ozlabs.org>
Date: Tue, 21 Jun 2016 10:40:50 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-18-05 at 01:16:51 UTC, Daniel Axtens wrote:
> Sometimes headers that provide prototypes for functions are
> accidentally omitted from the files that define the functions.
> 
> Fix a couple of times that occurs.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/665e87ffe1c400c525c3a4cd6f

cheers
