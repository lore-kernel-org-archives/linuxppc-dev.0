Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D690DEC97
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 00:26:38 +1000 (EST)
Message-Id: <9E570AE9-6811-489F-9E2C-EF5A6B95ED5C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <48AD7815.70107@linux.vnet.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
Date: Thu, 21 Aug 2008 09:21:39 -0500
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<81439C52-0CB6-4C46-9A97-3D30B84F58AF@kernel.crashing.org>
	<48AD7815.70107@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 21, 2008, at 9:13 AM, Christian Ehrhardt wrote:

> Kumar Gala wrote:
>>
>> On Aug 19, 2008, at 5:36 AM, ehrhardt@linux.vnet.ibm.com wrote:
>>
>>> From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
>>>
>>> Dependent on the already existing CONFIG_KVM_GUEST config option  
>>> this patch
>>> changes wrteei to wrtee allowing the hypervisor to rewrite those  
>>> to nontrapping
>>> instructions. Maybe we should split the kvm guest otpimizations in  
>>> two parts
>>> one for the overhead free optimizations and on for the rest that  
>>> might add
>>> some complexity for non virtualized execution (like this one).
>>>
>>> Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
>>> ---
>>
>> So this commit message doesnt explain why 'wrtee' facilities doing  
>> whatever optimization and 'wrteei' doesnt.
>>
> yep I only explained it elsewhere.
> I'll add it here too in the next version - thanks Kumar
> (and fix the word otpimizations)

Where is the other discussion?  I'd like to understand what's going on  
here.. (especially since I added the wrtee[i] changes to kernel way  
back when).

- k
