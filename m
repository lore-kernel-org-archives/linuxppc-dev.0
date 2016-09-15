Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZR085Mk6zDsWl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 14:54:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Michal Marek <mmarek@suse.cz>,
 linux-kbuild@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc/64: whitelist unresolved modversions CRCs
In-Reply-To: <20160914024507.8759-1-npiggin@gmail.com>
References: <20160914024507.8759-1-npiggin@gmail.com>
Date: Thu, 15 Sep 2016 14:54:14 +1000
Message-ID: <87a8f9oj9l.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> These are a symptom of CRC generation failure in generic
> build code, and not powerpc specific.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
