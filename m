Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6CBEDDDE05
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 17:57:05 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id m6O7uh2B025176
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 07:56:43 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m6O7uhKg3108970
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 09:56:43 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m6O7ugha014231
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 09:56:43 +0200
Message-ID: <488835B7.90702@linux.vnet.ibm.com>
Date: Thu, 24 Jul 2008 09:56:39 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 3/6] kvmppc: add hypercall infrastructure - guest part
References: <1216802207-32675-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1216802207-32675-4-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<20080724014538.GJ20457@bakeyournoodle.com>
In-Reply-To: <20080724014538.GJ20457@bakeyournoodle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, embedded-hypervisor@power.org, hollisb@us.ibm.com,
	kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tony Breeds wrote:
> On Wed, Jul 23, 2008 at 10:36:44AM +0200, ehrhardt@linux.vnet.ibm.com wrote:
>   
>> From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
>>     
>
> Hi Christian,
>   
>> This adds the guest portion of the hypercall infrastructure, basically an
>> illegal instruction with a defined layout.
>> See http://kvm.qumranet.com/kvmwiki/PowerPC_Hypercall_ABI for more detail
>> on the hypercall ABI for powerpc.
>>
>> Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
>> ---
>>
>> [diffstat]
>>  kvm_para.h |   16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> [diff]
>> diff --git a/include/asm-powerpc/kvm_para.h b/include/asm-powerpc/kvm_para.h
>> --- a/include/asm-powerpc/kvm_para.h
>> +++ b/include/asm-powerpc/kvm_para.h
>> @@ -25,6 +25,8 @@
>>  #ifdef __KERNEL__
>>  
>>  #include <linux/of.h>
>> +
>> +#define KVM_HYPERCALL_BIN 0x03ffffff
>>     
>
> Ummm didn't you add this in patch 2 of 6?
>   
This is just because I initially wanted to split Host & Guest patch series.
I need to separate my patches a bit more anyway for the next submission 
thanks for pointing out this duplication.

> Yours Tony
>
>   linux.conf.au    http://www.marchsouth.org/
>   Jan 19 - 24 2009 The Australian Linux Technical Conference!
>
>   


-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization
