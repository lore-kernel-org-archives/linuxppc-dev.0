Return-Path: <jimix@watson.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1451167B7C
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Jul 2006 04:24:25 +1000 (EST)
Received: from e4.ny.us.ibm.com (e4.pok.ibm.com [9.56.232.144])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6EG31i4022539
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 12:03:02 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6EG2vGt007260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 12:02:57 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6EG2vs8020050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 12:02:57 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6EG2vMf019453
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 12:02:57 -0400
Received: from [9.60.89.191] (dyn9060089191.endicott.ibm.com [9.60.89.191])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6EG2uQ9019442
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Jul 2006 12:02:57 -0400
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <4CE0FC89-084F-42E8-8E3B-8D2C41AC06F2@watson.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linuxppc-dev@ozlabs.org
From: Jimi Xenidis <jimix@watson.ibm.com>
Subject: Kexec initial registers
Date: Fri, 14 Jul 2006 12:02:56 -0400
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is what I have so far:

   r3: address of device tree blob
   r4: address that kernel was loaded
   r5: not OF (=0)
   r13: local_paca address (0?)

anything else?
Did I miss the document on this?

-JX
