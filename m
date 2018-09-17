Return-Path: <npiggin@gmail.com>
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DHwJ0H9mzF13x
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 17:35:27 +1000 (AEST)
Received: by mail-pl1-x643.google.com with SMTP id f6-v6so7010816plo.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 00:35:27 -0700 (PDT)
Date: Mon, 17 Sep 2018 17:35:18 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Joel Stanley <joel@jms.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH 01/12] powerpc/64s/hash: Fix stab_rr off by one
 initialization
Message-ID: <20180917173457.23c919b5@roar.ozlabs.ibm.com>
In-Reply-To: <CACPK8XcEQdSbUN=bRECfWeV6ZR2Pm9LM5wB83GSmAr63NH1hpg@mail.gmail.com>
References: <20180914153056.3644-1-npiggin@gmail.com>
 <20180914153056.3644-2-npiggin@gmail.com>
 <CACPK8XcEQdSbUN=bRECfWeV6ZR2Pm9LM5wB83GSmAr63NH1hpg@mail.gmail.com>
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

On Mon, 17 Sep 2018 16:21:51 +0930
Joel Stanley <joel@jms.id.au> wrote:

> On Sat, 15 Sep 2018 at 01:03, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > This causes SLB alloation to start 1 beyond the start of the SLB.

allocation

> > There is no real problem because after it wraps it stats behaving  
> 
> starts?
> 
> > properly, it's just surprisig to see when looking at SLB traces.  
> 
> surprising

My keyboard is dying :(
