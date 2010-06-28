Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id C467BB7085
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 18:15:20 +1000 (EST)
Message-ID: <4C285A13.8070208@redhat.com>
Date: Mon, 28 Jun 2010 11:15:15 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 18/26] KVM: PPC: KVM PV guest stubs
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-19-git-send-email-agraf@suse.de>
	<4C282794.1040209@ozlabs.org>
	<168E1B5F-44F7-4FF5-80A5-64B0E2E94D68@suse.de>
In-Reply-To: <168E1B5F-44F7-4FF5-80A5-64B0E2E94D68@suse.de>
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

On 06/28/2010 09:33 AM, Alexander Graf wrote:
>
>> Could you do something similar in module_finalize() to patch loaded modules' .text sections?
>>      
> I could, but do we need it? I objdump -d | grep'ed all my modules and didn't find any need to do so.
>    

You mean even kvm.ko doesn't use privileged instructions?

-- 
error compiling committee.c: too many arguments to function
