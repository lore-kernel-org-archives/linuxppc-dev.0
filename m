Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C22C71A0024
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 21:57:58 +1000 (EST)
Message-ID: <5429492C.4020908@suse.de>
Date: Mon, 29 Sep 2014 13:57:32 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: CMA: Reserve cma region only in
 hypervisor mode
References: <1411977758-24506-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <54291841.5040903@suse.de> <54294717.7040706@redhat.com>
In-Reply-To: <54294717.7040706@redhat.com>
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



On 29.09.14 13:48, Paolo Bonzini wrote:
> Il 29/09/2014 10:28, Alexander Graf ha scritto:
>>
>>
>> On 29.09.14 10:02, Aneesh Kumar K.V wrote:
>>> We use cma reserved area for creating guest hash page table.
>>> Don't do the reservation in non-hypervisor mode. This avoids unnecessary
>>> CMA reservation when booting with limited memory configs like
>>> fadump and kdump.
>>>
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>
>> Thanks, applied to kvm-ppc-queue.
> 
> Would you like this in 3.18?

Yes, can you please directly apply it with my SoB (or Reviewed-by if you
prefer)?


Alex
