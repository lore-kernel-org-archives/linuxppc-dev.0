Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vy5tr4CRdzDqKS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 21:13:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Haren Myneni <haren@linux.vnet.ibm.com>, herbert@gondor.apana.org.au,
 ddstreet@ieee.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 benh@kernel.crashing.org, mikey@neuling.org, suka@us.ibm.com, hbabu@us.ibm.com
Subject: Re: [PATCH 3/5] crypto/nx: Create nx842_delete_coproc function
In-Reply-To: <1491066046.29552.28.camel@hbabu-laptop>
References: <1491066046.29552.28.camel@hbabu-laptop>
Date: Tue, 04 Apr 2017 21:13:23 +1000
Message-ID: <87d1csv31o.fsf@concordia.ellerman.id.au>
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

> [PATCH 3/5] crypto/nx: Create nx842_delete_coproc function
>
> Move deleting coprocessor info upon exit or failure to
> nx842_delete_coproc().

Naming again, this deletes *all* the coprocs, so the name should be
plural.

cheers
