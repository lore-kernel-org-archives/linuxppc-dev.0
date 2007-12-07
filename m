Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 58273DDE0C
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 09:22:59 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB7MMuRv024748
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 17:22:56 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB7MMufE169222
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 15:22:56 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB7MMtQT004124
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Dec 2007 15:22:56 -0700
Message-ID: <4759C7BD.5060803@linux.vnet.ibm.com>
Date: Sat, 08 Dec 2007 03:52:53 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
	<200712072301.38723.arnd@arndb.de>
In-Reply-To: <200712072301.38723.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Friday 07 December 2007, Balbir Singh wrote:
>> Here's a dumb simple implementation of fake NUMA nodes for PowerPC. Fake
>> NUMA nodes can be specified using the following command line option
>>
>> numa=fake=<node range>
>>
>> node range is of the format <range1>,<range2>,...<rangeN>
> 
> Excellent idea! I'd love to have this in RHEL5u1, because that would make
> that distro boot on certain machines that have more memory than is supported
> without an iommu driver. The problem we have is that when you simply
> say mem=1G but all of the first gigabyte is on the first node, you end
> up with a memoryless node, which is not supported.
> 
> Unfortunately, it comes too late for me now, as all new distros already boot
> on Cell machines that need an IOMMU.

Very interesting use case! I am sure there are others were fake NUMA
nodes can be applied. I just listed one other in another email, apart
from using it for playing around with NUMA like machines.

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
