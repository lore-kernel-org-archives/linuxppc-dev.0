Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJhsm6ndgzDqZ3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 15:30:52 +1000 (AEST)
Message-ID: <1464672636.3078.247.camel@kernel.crashing.org>
Subject: Re: [PATCH 1/5] powerpc/pseries: Drop support for MPIC in pseries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Rashmica <rashmicy@gmail.com>,
 paulus@samba.org, nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 31 May 2016 15:30:36 +1000
In-Reply-To: <1464671068.32478.13.camel@ellerman.id.au>
References: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
 <1464593541.3078.192.camel@kernel.crashing.org>
 <574CEA20.5070809@gmail.com> <574CFB67.7000605@gmail.com>
 <1464671068.32478.13.camel@ellerman.id.au>
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

On Tue, 2016-05-31 at 15:04 +1000, Michael Ellerman wrote:
> I haven't heard of this "XIVE" thing but anyway ..
> 
> I would hope we can come up with a better abstraction than this for XICS/XIVE,
> so I'm inclined to merge this anyway. Worst case we end up putting some of it
> back.

Just merge it, I'll sort it out. If you haven't heard from XIVE, you
have better noise cancelling headphones than I thought ;-)

Cheers,
Ben.
