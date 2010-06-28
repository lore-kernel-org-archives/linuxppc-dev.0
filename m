Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id ECEDBB6F29
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 18:33:35 +1000 (EST)
Message-ID: <4C285E5C.4070605@redhat.com>
Date: Mon, 28 Jun 2010 11:33:32 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 18/26] KVM: PPC: KVM PV guest stubs
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-19-git-send-email-agraf@suse.de>
	<4C282794.1040209@ozlabs.org>
	<168E1B5F-44F7-4FF5-80A5-64B0E2E94D68@suse.de>
	<4C285A13.8070208@redhat.com>
	<AD79CD04-74CF-49B9-BACC-4C190DF5214A@suse.de>
In-Reply-To: <AD79CD04-74CF-49B9-BACC-4C190DF5214A@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, kvm-ppc@vger.kernel.org,
	Matt Evans <matt@ozlabs.org>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/28/2010 11:23 AM, Alexander Graf wrote:
>> You mean even kvm.ko doesn't use privileged instructions?
>>      
> It does, but I don't think it's worth speeding those up. There are only a couple. Most of the privileged instructions in PPC KVM are statically compiled into the kernel because we need to guarantee they're in the RMO (first 8MB for the PS3).
>
> Even with the magic page in use, trapping instructions still works exactly as before, so we're only talking about a speed difference.
>
>    

Yeah, that also answers my question re pv->nonpv transition.

-- 
error compiling committee.c: too many arguments to function
