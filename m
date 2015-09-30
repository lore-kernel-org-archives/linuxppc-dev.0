Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C82D01A002B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 11:44:31 +1000 (AEST)
Message-ID: <1443577471.5103.4.camel@ellerman.id.au>
Subject: Re: [PATCH 00/31] powerpc/mm: Update page table format for book3s 64
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scottwood@freescale.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 Sep 2015 11:44:31 +1000
In-Reply-To: <1443458480.32298.173.camel@freescale.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1442872135.19102.184.camel@freescale.com>
 <877fnj3q6m.fsf@linux.vnet.ibm.com>
 <1442905053.19102.228.camel@freescale.com>
 <87zj07gn06.fsf@linux.vnet.ibm.com>
 <1443458480.32298.173.camel@freescale.com>
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

On Mon, 2015-09-28 at 11:41 -0500, Scott Wood wrote:
> On Mon, 2015-09-28 at 10:26 +0530, Aneesh Kumar K.V wrote:
> > Scott Wood <scottwood@freescale.com> writes:
> > > 
> > > In any case, "nohash" is the term used elsewhere.
> > 
> > How about using swtlb ? (nohash always confused me, It would be nice to
> > be explict and us software tlb ?)
> 
> I'd prefer nohash.  Besides being existing practice (what's confusing about 
> it?), e6500 is nohash but has a partial hw tlb, and 603 is considered hash 
> despite having a software-loaded tlb.

It's not a great name because it describes what the MMU is *not*, rather than
what it *is*.

But it is the existing name, and there doesn't seem to be anything particular
common about the other MMUs that we can use as a name.

cheers
