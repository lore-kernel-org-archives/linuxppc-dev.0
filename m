Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D32CC1A0118
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 14:00:27 +1100 (AEDT)
Message-ID: <1457319627.19197.1.camel@ellerman.id.au>
Subject: Re: Problems with swapping in v4.5-rc on POWER
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hugh Dickins <hughd@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Date: Mon, 07 Mar 2016 14:00:27 +1100
In-Reply-To: <alpine.LSU.2.11.1603040948250.5477@eggly.anvils>
References: <alpine.LSU.2.11.1602241716220.15121@eggly.anvils>
 <877fhttmr1.fsf@linux.vnet.ibm.com>
 <alpine.LSU.2.11.1602242136270.6876@eggly.anvils>
 <alpine.LSU.2.11.1602251322130.8063@eggly.anvils>
 <alpine.LSU.2.11.1602260157430.10399@eggly.anvils>
 <alpine.LSU.2.11.1603021226300.31251@eggly.anvils>
 <1456984266.28236.1.camel@ellerman.id.au>
 <alpine.LSU.2.11.1603040948250.5477@eggly.anvils>
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

On Fri, 2016-03-04 at 09:58 -0800, Hugh Dickins wrote:
> 
> The alternative bisection was as unsatisfactory as the first:
> again it fingered an irrelevant merge (rather than any commit
> pulled in by that merge) as the bad commit.
> 
> It seems this issue is too intermittent for bisection to be useful,
> on my load anyway.

Darn. Thanks for trying.

> The best I can do now is try v4.4 for a couple of days, to verify that
> still comes out good (rather than the machine going bad coincident with
> v4.5-rc), then try v4.5-rc7 to verify that that still comes out bad.

Thanks, that would still be helpful.

> I'll report back on those; but beyond that, I'll have to leave it to you.

I haven't had any luck here :/

Can you give us a more verbose description of your test setup?

 - G5, which exact model?
 - 4k pages, no THP.
 - how much ram & swap?
 - building linus' tree, make -j ?
 - source and output on tmpfs? (how big?)
 - what device is the swap device? (you said SSD I think?)
 - anything else I've forgotten?

Oh and can you send us your bisect logs, we can at least trust the bad results
I think.

cheers
