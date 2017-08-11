Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTg2n1JhJzDr4K
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Aug 2017 08:41:04 +1000 (AEST)
Message-ID: <1502491248.4493.10.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/6] powerpc/mm: Ensure cpumask update is ordered
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com, Michael
 Ellerman <mpe@ellerman.id.au>
Date: Sat, 12 Aug 2017 08:40:48 +1000
In-Reply-To: <20170811210656.5a19dda1@roar.ozlabs.ibm.com>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-3-benh@kernel.crashing.org>
 <20170724212007.7f472332@roar.ozlabs.ibm.com>
 <20170811210656.5a19dda1@roar.ozlabs.ibm.com>
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

On Fri, 2017-08-11 at 21:06 +1000, Nicholas Piggin wrote:
> Other than that your series seems good to me if you repost it you
> can add
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> 
> This one out of the series is the bugfix so it should go to stable
> as well, right?

Yup.

Ben.
