Return-Path: <pbonzini@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63B271A003D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 22:22:12 +1000 (EST)
Message-ID: <54294EE8.6020106@redhat.com>
Date: Mon, 29 Sep 2014 14:22:00 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: CMA: Reserve cma region only in
 hypervisor mode
References: <1411977758-24506-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <54291841.5040903@suse.de> <54294717.7040706@redhat.com>
 <5429492C.4020908@suse.de>
In-Reply-To: <5429492C.4020908@suse.de>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 29/09/2014 13:57, Alexander Graf ha scritto:
> 
> 
> On 29.09.14 13:48, Paolo Bonzini wrote:
>> Il 29/09/2014 10:28, Alexander Graf ha scritto:
>>>
>>>
>>> On 29.09.14 10:02, Aneesh Kumar K.V wrote:
>>>> We use cma reserved area for creating guest hash page table.
>>>> Don't do the reservation in non-hypervisor mode. This avoids unnecessary
>>>> CMA reservation when booting with limited memory configs like
>>>> fadump and kdump.
>>>>
>>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>>
>>> Thanks, applied to kvm-ppc-queue.
>>
>> Would you like this in 3.18?
> 
> Yes, can you please directly apply it with my SoB (or Reviewed-by if you
> prefer)?

Ok, will do.

Paolo
