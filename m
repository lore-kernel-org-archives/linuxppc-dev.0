Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09F501A0D2D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 15:59:07 +1100 (AEDT)
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1A983140213
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2015 15:59:05 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Thu, 12 Nov 2015 23:59:04 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 5D93A38C8046
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2015 23:59:02 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAD4x2fQ56623226
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2015 04:59:02 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAD4x1UG013824
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2015 23:59:02 -0500
Message-ID: <56456E0C.1040909@linux.vnet.ibm.com>
Date: Fri, 13 Nov 2015 10:28:52 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: David Gibson <david@gibson.dropbear.id.au>, kvm@vger.kernel.org,
 michaele@au1.ibm.com, mahesh@linux.vnet.ibm.com, agraf@suse.de,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Exit guest upon fatal machine check exception
References: <20151111165845.3721.98296.stgit@aravindap>
 <876118ymy4.fsf@gamma.ozlabs.ibm.com> <20151112033816.GJ5852@voom.redhat.com>
 <87bnazizkp.fsf@gamma.ozlabs.ibm.com> <5644CABE.3010905@linux.vnet.ibm.com>
 <87pozezypm.fsf@gamma.ozlabs.ibm.com>
In-Reply-To: <87pozezypm.fsf@gamma.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 13 November 2015 03:07 AM, Daniel Axtens wrote:
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:
> 
>>> <puts on CAPI hat>Yeah, it would be good not to break this.</hat>
>>
>> I am not familiar with CAPI. Does this affect CAPI?
> 
> When a CAPI card experiences an EEH event, any cache lines it holds are
> filled with SUEs (Special UEs, interpreted by the kernel the same as
> regular UEs). When these are read, we get an MCE. Currently CAPI does
> not support virtualisation, but that is actively being worked
> on. There's a _very_ good chance it will then be backported to various
> distros, which could have old qemu.
> 
> Therefore, I'd ideally like to make sure UEs in KVM guests work properly
> and continue to do so in all combinations of kernel and qemu. I'm
> following up the email from Mahesh that you linked: I'm not sure I quite
> follow his logic so I'll try to make sense of that and then get back to
> you.

sure. Thanks.

Regards,
Aravinda

> 
> Regards,
> Daniel
> 

-- 
Regards,
Aravinda
