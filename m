Return-Path: <sachinp@in.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE89CDDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 22:22:14 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4MCMBGr011939
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 08:22:11 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4MCMBIE558090
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 08:22:11 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4MCMANX029658
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 08:22:11 -0400
Message-ID: <4652E088.9080207@in.ibm.com>
Date: Tue, 22 May 2007 17:52:32 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [Patch 0/2] Kexec/Kdump support POWER6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Milton Miller II <miltonm@us.ibm.com>, ellerman@au1.ibm.com
Reply-To: sachinp@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here are a set of patches which adds kdump support for Power6.

The first patch reads VRMA page size from device tree.

Second patch adds Kexec/Kdump support for Power6 processor. 
On Power machines supporting VRMA, Kexec/Kdump does not work.
Hypervisor stores VRMA mapping used by the OS, in the hpte 
hash tables. This patch makes sure these hpte entries are 
left untouched.

Comments are welcome.

Thanks
-Sachin

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>
---
