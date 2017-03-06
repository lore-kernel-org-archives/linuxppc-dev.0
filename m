Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc81L4kNFzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 16:46:46 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: pc@us.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc: A new cache geometry aux vectors
In-Reply-To: <288deec2-a821-316b-5e53-e186deda96f9@us.ibm.com>
References: <1486016558.4850.30.camel@kernel.crashing.org>
 <67e56596-05a7-5f3d-8125-a4e0194f1b7c@us.ibm.com>
 <877f48kx0q.fsf@concordia.ellerman.id.au>
 <3d15baac-1705-a1a6-d0b0-1d7f378509d6@us.ibm.com>
 <87fuivhuub.fsf@concordia.ellerman.id.au>
 <288deec2-a821-316b-5e53-e186deda96f9@us.ibm.com>
Date: Mon, 06 Mar 2017 16:46:46 +1100
Message-ID: <87r32bot2x.fsf@concordia.ellerman.id.au>
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

Paul Clarke <pc@us.ibm.com> writes:
> P9 (with bad device-tree):
> --
> # ./cache_shape
> test: cache_shape
> tags: git_version:v4.10-0-gc470abd-dirty
> L1I  cache size:          0          0B          0K
> L1I  line size:        0x80       fully associative
> L1D  cache size:          0          0B          0K
> L1D  line size:        0x80       fully associative
> L2   cache size:          0          0B          0K
> L2   line size:           0       fully associative
> L3   cache size:          0          0B          0K
> L3   line size:           0       fully associative
> success: cache_shape
> --

Hmm, which p9 mambo is this? I get:

test: cache_shape
tags: git_version:v4.10-10927-g0a55d1671c33
L1I  cache size:     0x8000      32768B         32K
L1I  line size:        0x80       128-way associative
L1D  cache size:     0x8000      32768B         32K
L1D  line size:        0x80       128-way associative
L2   cache size:          0          0B          0K
L2   line size:           0       fully associative
L3   cache size:          0          0B          0K
L3   line size:           0       fully associative
success: cache_shape

So that looks OK, other than that here is no L2/L3 info.

I'm using mambo commit e0c03c93c6d14c5f842840cc4ac4183cb25e123b.

>
> Do you want me to Ack your v3 patch set in that thread?

No don't bother, it's already merged so your ack wouldn't get included
in the git history. This mail thread is record enough that it got
tested by someone other than me.

Thanks for testing.

cheers
