Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D12BD1A0014
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 10:12:54 +1000 (AEST)
Message-ID: <1443485557.4610.36.camel@kernel.crashing.org>
Subject: Re: [PATCH 00/31] powerpc/mm: Update page table format for book3s 64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Scott Wood
 <scottwood@freescale.com>
Cc: paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 Sep 2015 10:12:37 +1000
In-Reply-To: <87zj07gn06.fsf@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442872135.19102.184.camel@freescale.com>
 <877fnj3q6m.fsf@linux.vnet.ibm.com>
 <1442905053.19102.228.camel@freescale.com>
 <87zj07gn06.fsf@linux.vnet.ibm.com>
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

On Mon, 2015-09-28 at 10:26 +0530, Aneesh Kumar K.V wrote:
> > In any case, "nohash" is the term used elsewhere.
> 
> How about using swtlb ? (nohash always confused me, It would be nice 
> to be explict and us software tlb ?)

Stick to nohash, that's been our convention so far, I don't see
the point in changing it.

Cheers,
Ben.
