Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vC2vW6LbZzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 08:43:35 +1100 (AEDT)
Message-ID: <1485808527.2980.134.camel@kernel.crashing.org>
Subject: Re: [PATCH 9/9] powerpc: A new cache geometry aux vectors
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Steven Munroe <munroesj@linux.vnet.ibm.com>
Date: Tue, 31 Jan 2017 07:35:27 +1100
In-Reply-To: <87bmuowaxq.fsf@concordia.ellerman.id.au>
References: <20170108233150.15353-1-benh@kernel.crashing.org>
 <20170108233150.15353-9-benh@kernel.crashing.org>
 <87bmuowaxq.fsf@concordia.ellerman.id.au>
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

On Tue, 2017-01-31 at 07:27 +1100, Michael Ellerman wrote:
> Will need some more macro foo.

That or make ppc64_caches ppc_caches, and make it common...

I'll look into it.

Cheers,
Ben.
