Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xcGs56SS5zDrK8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Aug 2017 02:55:37 +1000 (AEST)
Message-ID: <1503420928.2195.41.camel@kernel.crashing.org>
Subject: Re: [PATCH 5/6] powerpc/mm: Optimize detection of thread local mm's
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Date: Tue, 22 Aug 2017 09:55:28 -0700
In-Reply-To: <2c6b25af-6459-d1da-6f56-5d9cc4bdc26f@linux.vnet.ibm.com>
References: <20170724042803.25848-1-benh@kernel.crashing.org>
 <20170724042803.25848-5-benh@kernel.crashing.org>
 <ad84e763-a30f-04f7-f1d0-ccd72c0d4dd4@linux.vnet.ibm.com>
 <1503336930.2195.20.camel@kernel.crashing.org>
 <2c6b25af-6459-d1da-6f56-5d9cc4bdc26f@linux.vnet.ibm.com>
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

On Tue, 2017-08-22 at 15:18 +0200, Frederic Barrat wrote:
> > Or you could just incrementer my counter. Just make sure you increment
> > it at most once per CXL context and decrement when the context is gone.
> 
> Ah great, I didn't dare messing with your counter, it makes it easier. 
> Arguably what happens on those accelerators is pretty close to an active 
> cpu.
> 
> Once it is merged, I'm going to have to backport your patch (and an 
> update to mine) to the p9-supporting distros. From a quick look, your 
> patch, i.e."[PATCH 5/6] powerpc/mm: Optimize detection of thread local 
> mm's" is completely independent from the rest of the series, right?

We also need the memory barrier fix but yes.

Cheers,
Ben.
