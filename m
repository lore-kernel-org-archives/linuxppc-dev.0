Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA7E21A11B7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 20:24:50 +1100 (AEDT)
Message-ID: <1427275489.31588.1.camel@ellerman.id.au>
Subject: Re: [PATCH 5/6] mm/gup: Replace ACCESS_ONCE with READ_ONCE for
 STRICT_MM_TYPECHECKS
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 25 Mar 2015 20:24:49 +1100
In-Reply-To: <55127D65.7060605@de.ibm.com>
References: <1427274719-25890-1-git-send-email-mpe@ellerman.id.au>
 <1427274719-25890-5-git-send-email-mpe@ellerman.id.au>
 <55127D65.7060605@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aarcange@redhat.com, aneesh.kumar@in.ibm.com, steve.capper@linaro.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>,
 kirill.shutemov@linux.intel.com, Jason Low <jason.low2@hp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-03-25 at 10:18 +0100, Christian Borntraeger wrote:
> Am 25.03.2015 um 10:11 schrieb Michael Ellerman:
> > If STRICT_MM_TYPECHECKS is enabled the generic gup code fails to build
> > because we are using ACCESS_ONCE on non-scalar types.
> > 
> > Convert all uses to READ_ONCE.
> 
> There is a similar patch from Jason Low in Andrews patch.

Ah sorry, I didn't think to check.

> If that happens in 4.0-rc, we probably want to merge this before 4.0.

My series can wait, it's not urgent. So I'll plan to merge mine once Andrew's
tree has gone into Linus' tree for 4.1.

cheers
