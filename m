Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgk3mzzzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:30 +1000 (AEST)
In-Reply-To: <20180530131804.1706-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/mm/hash: Add missing update in slb update sequence.
Message-Id: <40zxgk1nHPz9s0w@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-30 at 13:18:04 UTC, "Aneesh Kumar K.V" wrote:
> >From ISA
> 
> "For data accesses, the context synchronizing instruction before the slbie,
> slbieg, slbia, slbmte, tlbie, or tlbiel instruction ensures that all preceding
> instructions that access data storage have completed to a point at which they
> have reported all exceptions they will cause."
> 
> Add the missing isync when updating Kernel stack slb entry.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/91d06971881f71d945910de1286580

cheers
