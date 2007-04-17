Return-Path: <bigeasy@linux.vnet.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 14658DDE33
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 22:24:03 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l3HCNwxB016908
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 12:23:58 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l3HCNvni1540110
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 13:23:57 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l3HCNvU6025625
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 13:23:57 +0100
Received: from [9.152.237.70] (dyn-9-152-237-70.boeblingen.de.ibm.com
	[9.152.237.70])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.12.11) with ESMTP
	id l3HCNvQf025607
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 13:23:57 +0100
Message-Id: <20070417115206.709701000@linux.vnet.ibm.com>>
Date: Tue, 17 Apr 2007 13:52:06 +0200
From: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 0/3] Experiments with AES-AltiVec, part 2
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I implemented ECB & CBC block mode for AES. This implementation performs
better then my initial attempt but the generic code is better in most 
cases therefore no need to add it to the kernel.

Sebastian
--
