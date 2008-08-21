Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [194.196.100.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 18579DE772
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 00:13:54 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.1/8.13.1) with ESMTP id m7LEDhdS019817
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 14:13:43 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7LEDh913027078
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 15:13:43 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7LEDhCV024524
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 15:13:43 +0100
Message-ID: <48AD7815.70107@linux.vnet.ibm.com>
Date: Thu, 21 Aug 2008 16:13:41 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<81439C52-0CB6-4C46-9A97-3D30B84F58AF@kernel.crashing.org>
In-Reply-To: <81439C52-0CB6-4C46-9A97-3D30B84F58AF@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Aug 19, 2008, at 5:36 AM, ehrhardt@linux.vnet.ibm.com wrote:
>
>> From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
>>
>> Dependent on the already existing CONFIG_KVM_GUEST config option this 
>> patch
>> changes wrteei to wrtee allowing the hypervisor to rewrite those to 
>> nontrapping
>> instructions. Maybe we should split the kvm guest otpimizations in 
>> two parts
>> one for the overhead free optimizations and on for the rest that 
>> might add
>> some complexity for non virtualized execution (like this one).
>>
>> Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
>> ---
>
> So this commit message doesnt explain why 'wrtee' facilities doing 
> whatever optimization and 'wrteei' doesnt.
>
yep I only explained it elsewhere.
I'll add it here too in the next version - thanks Kumar
(and fix the word otpimizations)

-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization
