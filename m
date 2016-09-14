Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZJ2y1H0qzDrqP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 09:41:14 +1000 (AEST)
Date: Thu, 15 Sep 2016 09:41:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michal Marek <mmarek@suse.cz>, linux-kbuild@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64: whitelist unresolved modversions CRCs
Message-ID: <20160915094113.3d4b1777@canb.auug.org.au>
In-Reply-To: <20160914024507.8759-1-npiggin@gmail.com>
References: <20160914024507.8759-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Wed, 14 Sep 2016 12:45:07 +1000 Nicholas Piggin <npiggin@gmail.com> wrote:
>
> These are a symptom of CRC generation failure in generic
> build code, and not powerpc specific.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

OK, so I will use this as a merge fix patch for the kbuild tree today
(instead of the revert I have been doing).

-- 
Cheers,
Stephen Rothwell
