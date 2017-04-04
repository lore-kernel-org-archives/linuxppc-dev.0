Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy5x91BdFzDqWJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 21:15:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Haren Myneni <haren@linux.vnet.ibm.com>, herbert@gondor.apana.org.au,
 ddstreet@ieee.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 benh@kernel.crashing.org, mikey@neuling.org, suka@us.ibm.com, hbabu@us.ibm.com
Subject: Re: [PATCH 5/5] crypto/nx: Add P9 NX specific error codes for 842
 engine
In-Reply-To: <1491066154.29552.30.camel@hbabu-laptop>
References: <1491066154.29552.30.camel@hbabu-laptop>
Date: Tue, 04 Apr 2017 21:15:24 +1000
Message-ID: <87a87wv2yb.fsf@concordia.ellerman.id.au>
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

Haren Myneni <haren@linux.vnet.ibm.com> writes:

> [PATCH 5/5] crypto/nx: Add P9 NX specific error codes for 842 engine
>
> This patch adds changes for checking P9 specific 842 engine
> error codes. These errros are reported in co-processor status
> block (CSB) for failures.

But you just enabled support on P9 in patch 4.

So you should reorder patch 4 and 5. ie. add the P9 error handling
before you enable P9 support.

cheers
