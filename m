Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x22f.google.com (mail-pl0-x22f.google.com
 [IPv6:2607:f8b0:400e:c01::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwzVG2dGqzF1dZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 14:22:45 +1100 (AEDT)
Received: by mail-pl0-x22f.google.com with SMTP id s13-v6so568356plq.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 19:22:45 -0800 (PST)
Date: Wed, 7 Mar 2018 13:22:32 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Christophe Leroy
 <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 10/10] powerpc/mm/slice: use the dynamic high slice
 size to limit bitmap operations
Message-ID: <20180307132232.4fe41c3b@roar.ozlabs.ibm.com>
In-Reply-To: <20180307013718.13749-11-npiggin@gmail.com>
References: <20180307013718.13749-1-npiggin@gmail.com>
 <20180307013718.13749-11-npiggin@gmail.com>
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

On Wed,  7 Mar 2018 11:37:18 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> The number of high slices a process might use now depends on its
> address space size, and what allocation address it has requested.
> 
> This patch uses that limit throughout call chains where possible,
> rather than use the fixed SLICE_NUM_HIGH for bitmap operations.
> This saves some cost for processes that don't use very large address
> spaces.
> 
> Perormance numbers aren't changed significantly, this may change
> with larger address spaces or different mmap access patterns that
> require more slice mask building.


Ignore this patch in the series. I didn't intend to send it.

Thanks,
Nick
