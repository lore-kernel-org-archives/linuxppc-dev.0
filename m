Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-wg0-x22e.google.com (mail-wg0-x22e.google.com
 [IPv6:2a00:1450:400c:c00::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 466EF1A0001
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 21:48:47 +1000 (EST)
Received: by mail-wg0-f46.google.com with SMTP id k14so2774009wgh.29
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Sep 2014 04:48:44 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <54294717.7040706@redhat.com>
Date: Mon, 29 Sep 2014 13:48:39 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] KVM: PPC: BOOK3S: HV: CMA: Reserve cma region only in
 hypervisor mode
References: <1411977758-24506-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <54291841.5040903@suse.de>
In-Reply-To: <54291841.5040903@suse.de>
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

Il 29/09/2014 10:28, Alexander Graf ha scritto:
> 
> 
> On 29.09.14 10:02, Aneesh Kumar K.V wrote:
>> We use cma reserved area for creating guest hash page table.
>> Don't do the reservation in non-hypervisor mode. This avoids unnecessary
>> CMA reservation when booting with limited memory configs like
>> fadump and kdump.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> Thanks, applied to kvm-ppc-queue.

Would you like this in 3.18?

Paolo
