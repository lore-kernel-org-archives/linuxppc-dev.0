Return-Path: <ostampflee@terrasoftsolutions.com>
Received: from newhope.terraplex.com (newhope1.terraplex.com [66.7.161.2])
	by ozlabs.org (Postfix) with ESMTP id AD5E567B80
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 03:50:32 +1000 (EST)
Received: from [192.168.10.120] (unknown [192.168.10.120])
	by newhope.terraplex.com (Postfix) with ESMTP id 7C35C358035
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 11:21:16 -0600 (MDT)
Subject: vm_region_alloc failing
From: Owen Stampflee <ostampflee@terrasoftsolutions.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 28 Jun 2006 10:21:18 -0700
Message-Id: <1151515279.13982.12.camel@beast.terraplex.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I am currently working on getting OFED (an Infiniband stack) working on
an Extreme Engineering Xpdite4000
( http://xes-inc.com/Products/XPedite4000/XPedite4000.html ) with 2.6.11
(the vendor supplied kernel). 

The IB code calls dma_alloc_consistant 1024 times which then calls
vm_region_alloc. On the 501st iteration vm_region_alloc fails because
addr is greater than end (nospc). 

With that known, I am curious as to what would cause that type failure
and what potential fixes there are for it.

Thanks,
Owen
