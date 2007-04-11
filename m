Return-Path: <bigeasy@linux.vnet.ibm.com>
Received: from mtagate4.uk.ibm.com (mtagate4.uk.ibm.com [195.212.29.137])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 57895DDE47
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 03:17:58 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate4.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l3BHHrCo103392
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 17:17:53 GMT
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
	[9.149.37.216])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3BHHreK2850962
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:17:53 +0100
Received: from d06av04.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3BHHrng007888
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:17:53 +0100
Received: from [9.152.237.70] (dyn-9-152-237-70.boeblingen.de.ibm.com
	[9.152.237.70])
	by d06av04.portsmouth.uk.ibm.com (8.12.11.20060308/8.12.11) with ESMTP
	id l3BHHqEB007872
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 18:17:52 +0100
Message-Id: <20070411164910.657151000@linux.vnet.ibm.com>>
Date: Wed, 11 Apr 2007 18:49:10 +0200
From: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 0/3] Experiments with AES-AltiVec
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I tried to use SIMD instructions for AES. This is stage 1 with AltiVec support,
the next will be on SPUs. Unfortunately it is slower than the generic code on my
ps3. It might be faster on some other machine. I'm interrested in hearing
numbers from other people.
--
