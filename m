Return-Path: <segher@kernel.crashing.org>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B38A067CA4
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Jul 2005 06:47:34 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id j6EKlTYR045028
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2005 20:47:29 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j6EKlTW9169568
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2005 22:47:29 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j6EKlSAO005120
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jul 2005 22:47:29 +0200
In-Reply-To: <E6D8678E-33FD-492F-A773-12B0F87C2EBB@freescale.com>
References: <20050714125232.GA13456@janus>
	<E6D8678E-33FD-492F-A773-12B0F87C2EBB@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <22f5c933434d80ecf710fa1e471c2f5a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Thu, 14 Jul 2005 22:48:26 +0200
To: Kumar Gala <kumar.gala@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Using lswi/stswi inside the kernel
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Yes, not all PowerPC implementations actually implement this 
> instructions.  Also, on a number of them there is no performance 
> improvement when using the instructions.

Read: severe performance degradation ;-)


Segher
