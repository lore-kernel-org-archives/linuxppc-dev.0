Return-Path: <ehrhardt@linux.vnet.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 14CEBDDF74
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 18:08:16 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.8/8.13.8) with ESMTP id m7M88AWE562396
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 08:08:10 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m7M88AdL3395664
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 10:08:10 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m7M889lx015521
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 10:08:10 +0200
Message-ID: <48AE73E2.2010706@linux.vnet.ibm.com>
Date: Fri, 22 Aug 2008 10:08:02 +0200
From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<81439C52-0CB6-4C46-9A97-3D30B84F58AF@kernel.crashing.org>
	<48AD7815.70107@linux.vnet.ibm.com>
	<9E570AE9-6811-489F-9E2C-EF5A6B95ED5C@kernel.crashing.org>
	<20080821161622.GB15669@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080821161622.GB15669@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org, hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Thu, Aug 21, 2008 at 09:21:39AM -0500, Kumar Gala wrote:
>   
>> Where is the other discussion?  I'd like to understand what's going on  
>> here.. (especially since I added the wrtee[i] changes to kernel way  
>> back when).
>>     
>
> Presumably, they want to be able to replace wrtee with a store to a
> hypervisor/guest shared memory area, and there's no store-immediate
> instruction.
>
> -Scott
>   
Exactly Scott

And for your question Kumar, in the last submission I was asked to split 
host and guest patches.
So the host discussion lives on kvm-ppc@vger.kernel.org as I mentioned 
(maybe a bit too hidden)
in the [0/4] mail of this series.


-- 

Grüsse / regards, 
Christian Ehrhardt
IBM Linux Technology Center, Open Virtualization
