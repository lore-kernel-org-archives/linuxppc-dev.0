Return-Path: <nacc@us.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AAEFAB70DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  1 Dec 2010 11:32:05 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oB11NUuO010917
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Nov 2010 18:23:30 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oB10Vrnk194368
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Nov 2010 17:31:53 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oB10Vq59018521
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Nov 2010 17:31:53 -0700
Date: Tue, 30 Nov 2010 16:31:50 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 14/15] ppc64 iommu: use coherent_dma_mask for
	alloc_coherent
Message-ID: <20101201003150.GB3548@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-15-git-send-email-nacc@us.ibm.com>
	<1290992296.32570.215.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290992296.32570.215.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 29.11.2010 [11:58:16 +1100], Benjamin Herrenschmidt wrote:
> On Wed, 2010-09-15 at 11:05 -0700, Nishanth Aravamudan wrote:
> > The IOMMU code has been passing the dma-mask instead of the
> > coherent_dma_mask to the iommu allocator.  Coherent allocations should
> > be made using the coherent_dma_mask.
> 
> Won't that break macio devices too ? afaik, they don't set
> coherent_dma_mask. Have you tried booting on a G5 with iommu enabled ?
> 
> (It may not be broken, just asking...)

I have not tried this. I unfortunately do not have immediate access to a
G5 to test on, but will ask around.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
