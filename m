Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxDCb3mybzDqHH
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Apr 2017 10:54:51 +1000 (AEST)
Date: Mon, 3 Apr 2017 10:54:34 +1000
From: Anton Blanchard <anton@samba.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Add POWER9 copy_page() loop
Message-ID: <20170403105434.60309d3e@kryten>
In-Reply-To: <20170321142139.3072b9b6@roar.ozlabs.ibm.com>
References: <20170320234046.32718-1-anton@ozlabs.org>
 <20170321130109.1dd058c0@roar.ozlabs.ibm.com>
 <20170321150103.6c1336bd@kryten>
 <20170321142139.3072b9b6@roar.ozlabs.ibm.com>
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

> > Good idea, I hadn't thought of embedding it all in a feature
> > section.  
> 
> It may not work currently because you get those ftr_alt_97 relocation
> errors with the "else" parts because relative branches to other code
> need to be direct and I think reachable from both places.

I thought about this a bit more. One potential issue will be
profiling - perf annotate will match the samples against the unpatched
code which could be very confusing.

Anton
