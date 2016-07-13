Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqM850wvyzDqFZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 00:45:40 +1000 (AEST)
Message-ID: <1468421132.20552.93.camel@kernel.crashing.org>
Subject: Re: [PATCH for-4.8 02/10] powerpc/mm: Convert early cpu/mmu feature
 check to use the new helpers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 13 Jul 2016 09:45:32 -0500
In-Reply-To: <87k2gpy6nl.fsf@skywalker.in.ibm.com>
References: <1468402690-5373-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1468402690-5373-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1468411747.20552.81.camel@kernel.crashing.org>
 <87k2gpy6nl.fsf@skywalker.in.ibm.com>
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

On Wed, 2016-07-13 at 19:36 +0530, Aneesh Kumar K.V wrote:
> > I'm not sure about that. This is converting way way way way more
> > functions than is needed. Especially if Michael applies my series
> > there will be very little code run before the patching, really only
> the
> > MMU initialization....
> 
> 
> Michael is also running into boot issues with the early init rewrite
> patch series on G5. That is why I didn't rebase my patches on top of
> that changes.

Well that shouldn't be too hard to fix when I'm back next week. It's
working fine on my quad G5 ;-)

Cheers,
Ben.
