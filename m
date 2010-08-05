Return-Path: <dipraksh@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 74852B70DB
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 15:32:41 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp05.au.ibm.com (8.14.4/8.13.1) with ESMTP id o755SJMp025867
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Aug 2010 15:28:19 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o755WePx1618024
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Aug 2010 15:32:40 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o755WepH011302
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Aug 2010 15:32:40 +1000
Message-ID: <4C5A4CF4.4070203@linux.vnet.ibm.com>
Date: Thu, 05 Aug 2010 11:02:36 +0530
From: divya <dipraksh@linux.vnet.ibm.com>
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org,
	linuxppc-dev@ozlabs.org, netdev <netdev@vger.kernel.org>,
	jeffrey.t.kirsher@intel.com
Subject: [linux-next] build failure
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Yestersday's linux-next(2.6.35_next_20100802) build fails with the following error on both system p and x.


   drivers/net/ixgbe/ixgbe_main.c: In function 'ixgbe_select_queue':
   drivers/net/ixgbe/ixgbe_main.c:6159: error: 'struct ixgbe_fcoe' has no member named 'up'
   drivers/net/ixgbe/ixgbe_main.c: In function 'ixgbe_xmit_frame':
   drivers/net/ixgbe/ixgbe_main.c:6221: error: 'struct ixgbe_fcoe' has no member named 'up'
   make[3]: *** [drivers/net/ixgbe/ixgbe_main.o] Error 1
   make[2]: *** [drivers/net/ixgbe] Error 2
   make[2]: *** Waiting for unfinished jobs....
   make[1]: *** [drivers/net] Error 2
   make: *** [drivers] Error 2

Thanks
Divya
