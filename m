Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 18AF11A04EB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Dec 2014 20:11:02 +1100 (AEDT)
Message-ID: <1418202661.9279.1.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] perf/power/hv-24x7: Use kmem_cache_free() instead
 of kfree
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Wed, 10 Dec 2014 20:11:01 +1100
In-Reply-To: <20141210070917.GB27377@us.ibm.com>
References: <20141210070637.GA27377@us.ibm.com>
 <20141210070917.GB27377@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jiri Olsa <jolsa@redhat.com>, dev@codyps.com,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-12-09 at 23:09 -0800, Sukadev Bhattiprolu wrote:
> From 982bf5a660ae33fbe2f9187187caa6752c66783d Mon Sep 17 00:00:00 2001
> From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Date: Wed, 10 Dec 2014 01:43:34 -0500
> Subject: [PATCH 2/2] power/perf: hv-24x7: Use kmem_cache_free() instead of
>  kfree

This got a bit munged, ...

> Use kmem_cache_free() to free a buffer allocated with kmem_cache_alloc().
> 
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> 
> p#	set2.log

.. and here too.

I can fix it up this time.

cheers
