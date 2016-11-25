Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQ8GF2zL0zDvv5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 19:23:01 +1100 (AEDT)
Message-ID: <1480062167.11342.2.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 1/7] powerpc/mm: update ptep_set_access_flag to not
 do full mm tlb flush
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@ozlabs.org>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Fri, 25 Nov 2016 19:22:47 +1100
In-Reply-To: <87d1hkjaya.fsf@linux.vnet.ibm.com>
References: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
 <20161125024843.GA24925@fergus.ozlabs.ibm.com>
 <87fumgjimq.fsf@linux.vnet.ibm.com> <87d1hkjaya.fsf@linux.vnet.ibm.com>
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

On Fri, 2016-11-25 at 12:35 +0530, Aneesh Kumar K.V wrote:
> Now the question will be how will we support _PAGE_DEVMAP (for
> nvidmm).
> We don't have free software pte bits after we make the above change.
> 
> NOTE: We do have 3 reserved bits(ppc bit 4-6 ) can we use that ?

Yes, I think we can, at least as long as it's a DD1 thing only, future
processors might re-use these.

Cheers,
Ben.
