Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2DDE3DDE08
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 15:32:53 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB84YWUH012801
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 23:34:32 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB84Woao491366
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 23:32:50 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB84Wnvn007555
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 23:32:50 -0500
Message-ID: <475A1E6E.3010303@linux.vnet.ibm.com>
Date: Sat, 08 Dec 2007 10:02:46 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<20071207221106.GH16824@localdomain>
	<4759C89B.9000709@linux.vnet.ibm.com>
	<alpine.DEB.0.9999.0712071510370.27689@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.0.9999.0712071510370.27689@chino.kir.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Rientjes wrote:
> On Sat, 8 Dec 2007, Balbir Singh wrote:
> 
>> Yes, they all appear on node 0. We could have tweaks to distribute CPU's
>> as well.
>>
> 
> You're going to want to distribute the cpu's based on how they match up 
> physically with the actual platform that you're running on.  x86_64 does 

Could you explain this better, how does it match up CPU's with fake NUMA
memory? Is there some smartness there? I'll try and look at the code and
also see what I can do for PowerPC

> this already and it makes fake NUMA more useful because it matches the 
> real-life case more often.

Yes, I agree, but I don't want that to be the first step for fake NUMA
nodes on PowerPC. I think we can incrementally add features.

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
