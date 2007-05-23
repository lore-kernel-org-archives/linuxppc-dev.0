Return-Path: <sachinp@in.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2FAA9DDE11
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 19:31:59 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l4N9S2TC013694
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 05:28:02 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4N9VqUM252204
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 03:31:52 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4N9Vp7l032536
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 03:31:52 -0600
Message-ID: <46540A18.8090506@in.ibm.com>
Date: Wed, 23 May 2007 15:02:08 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: [Patch 0/2] Kexec/Kdump support POWER6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Olof Johansson <olof@lixom.net>, Milton Miller II <miltonm@us.ibm.com>,
	ellerman@au1.ibm.com
Reply-To: sachinp@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is updated set of patches which adds kdump support for Power6.

The first patch reads VRMA page size from device tree.

Second patch adds Kexec/Kdump support for Power6 processor. 
On Power machines supporting VRMA, Kexec/Kdump does not work.
Hypervisor stores VRMA mapping used by the OS, in the hpte 
hash tables. This patch makes sure these hpte entries are 
left untouched.

Thanks
-Sachin

Signed-off-by : Sachin Sant <sachinp@in.ibm.com>
Signed-off-by : Mohan Kumar M <mohan@in.ibm.com>
---
