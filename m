Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02B2A1A0E20
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jun 2015 19:45:49 +1000 (AEST)
Message-ID: <1434534342.28933.5.camel@ellerman.id.au>
Subject: Re: [PATCH v2 2/2] powerpc/mm: Change the swap encoding in pte.
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org
Date: Wed, 17 Jun 2015 19:45:42 +1000
In-Reply-To: <87616ngi8x.fsf@linux.vnet.ibm.com>
References: <1434509021-24168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1434509021-24168-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87616ngi8x.fsf@linux.vnet.ibm.com>
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

On Wed, 2015-06-17 at 08:21 +0530, Aneesh Kumar K.V wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
> 
> 
> Hi Scott,
> 
> > Current swap encoding in pte can't support large pfns
> > above 4TB. Change the swap encoding such that we put
> > the swap type in the PTE bits. Also add build checks
> > to make sure we don't overlap with HPTEFLAGS.
> >
> 
> Can you please review this w.r.t 64bit booke ? 

I booted it on our p5020ds FWIW.

cheers
