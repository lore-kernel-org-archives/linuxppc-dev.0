Return-Path: <mhocko@kernel.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJfsC5PmkzDrMm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 17:01:35 +1000 (AEST)
Date: Fri, 28 Jul 2017 09:01:31 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 "Kirill A . Shutemov" <kirill@shutemov.name>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/3] powerpc/mm: update pmdp_invalidate to return old
 pmd value
Message-ID: <20170728070131.GE2274@dhcp22.suse.cz>
References: <20170727083756.32217-1-aneesh.kumar@linux.vnet.ibm.com>
 <20170727125449.GB27766@dhcp22.suse.cz>
 <a30c566c-20ab-d3ad-1f5f-47524a97c2a3@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a30c566c-20ab-d3ad-1f5f-47524a97c2a3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu 27-07-17 21:18:35, Aneesh Kumar K.V wrote:
> 
> 
> On 07/27/2017 06:24 PM, Michal Hocko wrote:
> >EMISSING_CHANGELOG
> >
> >besides that no user actually uses the return value. Please fold this
> >into the patch which uses the new functionality.
> 
> 
> The patch series was suppose to help Kirill to make progress with the his
> series at
> 
> 
> https://lkml.kernel.org/r/20170615145224.66200-1-kirill.shutemov@linux.intel.com
> 
> It is essentially implementing the pmdp_invalidate update for ppc64. His
> series does it for x86-64.

OK, that was not clear from the patch, however. You could either reply
to the original thread or make it explicitly clear in the cover letter.
-- 
Michal Hocko
SUSE Labs
