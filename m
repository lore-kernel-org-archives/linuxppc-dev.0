Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxxZP3B6PzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 20:59:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Cc: Russell Currey <ruscur@au1.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/eeh: Create PHB PEs after EEH is initialized
In-Reply-To: <1504766140.12628.14.camel@kernel.crashing.org>
References: <1504766140.12628.14.camel@kernel.crashing.org>
Date: Wed, 20 Sep 2017 20:59:08 +1000
Message-ID: <87h8vxljpf.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Otherwise we end up not yet having computed the right
> diag data size on powernv where EEH initialization
> is delayed, thus causing memory corruption later on
> when calling OPAL.

When did this break? Do we have a commit we can tag with Fixes: ?
Stable?

I assume we want to merge this ASAP as a fix, I think I can safely take
this without patch 2?

cheers
