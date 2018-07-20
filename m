Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Wwkl1F7JzDqC8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2018 13:06:07 +1000 (AEST)
Date: Fri, 20 Jul 2018 13:06:02 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kernel,v7,1/2] vfio/spapr: Use IOMMU pageshift rather than
 pagesize
Message-ID: <20180720030602.GA16075@fergus>
References: <20180717071913.2167-2-aik@ozlabs.ru> <41WNmy1B2zz9s1R@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41WNmy1B2zz9s1R@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 19, 2018 at 04:06:10PM +1000, Michael Ellerman wrote:
> On Tue, 2018-07-17 at 07:19:12 UTC, Alexey Kardashevskiy wrote:
> > The size is always equal to 1 page so let's use this. Later on this will
> > be used for other checks which use page shifts to check the granularity
> > of access.
> > 
> > This should cause no behavioral change.
> > 
> > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > Acked-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Applied to powerpc fixes, thanks.
> 
> https://git.kernel.org/powerpc/c/1463edca6734d42ab4406fa2896e20

Ah.  I have put these two patches in my kvm-ppc-next branch and I was
about to send a pull request to Paolo.

Paul.
