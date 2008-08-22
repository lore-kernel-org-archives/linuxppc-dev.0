Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BD700DE4DA
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 18:18:04 +1000 (EST)
Message-Id: <542DF8C9-8EB7-40D9-AC66-67D4CF7598F6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <48AE73E2.2010706@linux.vnet.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
Date: Fri, 22 Aug 2008 03:17:33 -0500
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<81439C52-0CB6-4C46-9A97-3D30B84F58AF@kernel.crashing.org>
	<48AD7815.70107@linux.vnet.ibm.com>
	<9E570AE9-6811-489F-9E2C-EF5A6B95ED5C@kernel.crashing.org>
	<20080821161622.GB15669@ld0162-tx32.am.freescale.net>
	<48AE73E2.2010706@linux.vnet.ibm.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	kvm-ppc@vger.kernel.org, hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2008, at 3:08 AM, Christian Ehrhardt wrote:

> Scott Wood wrote:
>> On Thu, Aug 21, 2008 at 09:21:39AM -0500, Kumar Gala wrote:
>>
>>> Where is the other discussion?  I'd like to understand what's  
>>> going on  here.. (especially since I added the wrtee[i] changes to  
>>> kernel way  back when).
>>>
>>
>> Presumably, they want to be able to replace wrtee with a store to a
>> hypervisor/guest shared memory area, and there's no store-immediate
>> instruction.
>>
>> -Scott
>>
> Exactly Scott
>
> And for your question Kumar, in the last submission I was asked to  
> split host and guest patches.
> So the host discussion lives on kvm-ppc@vger.kernel.org as I  
> mentioned (maybe a bit too hidden)
> in the [0/4] mail of this series.

Maybe I'm missing something but it seems like just changing the code  
to wrtee isn't the best way to ensure you have enough space to put the  
set of instructions you guys want.

- k
