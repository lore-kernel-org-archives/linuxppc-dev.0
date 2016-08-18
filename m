Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFTjV4chxzDr5Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 00:57:50 +1000 (AEST)
Date: Thu, 18 Aug 2016 09:57:40 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 ego@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PowerPC] today's main line failed to build on PowerPC
Message-ID: <20160818145740.GA24467@gate.crashing.org>
References: <fcd669dc-7ad2-aeff-fb66-14c06c4f9a7d@linux.vnet.ibm.com>
 <840a5ac9-8de2-4765-9344-21abe8c0e67a@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <840a5ac9-8de2-4765-9344-21abe8c0e67a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 18, 2016 at 12:48:17PM +0530, Abdul Haleem wrote:
> >09:34:24 00:05:01 ERROR| [stderr] arch/powerpc/mm/hash_low_32.S: 
> >Assembler messages:
> >09:34:24 00:05:01 ERROR| [stderr] arch/powerpc/mm/hash_low_32.S:353: 
> >Error: missing operand
> >09:34:24 00:05:01 ERROR| [stderr] arch/powerpc/mm/hash_low_32.S:612: 
> >Error: missing operand
> >09:34:24 00:05:01 ERROR| [stderr] arch/powerpc/mm/hash_low_32.S:670: 
> >Error: missing operand

You're building 32-bit no-smp...

> CONFIG_SMP=y
> CONFIG_WORD_SIZE=64

... but your config says otherwise.  Some (re-)configuration mishap?


Segher
