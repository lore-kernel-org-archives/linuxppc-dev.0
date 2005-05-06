Return-Path: <segher@kernel.crashing.org>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de.ibm.com", Issuer "Equifax" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 1E7A467A64
	for <linuxppc-dev@ozlabs.org>; Sat,  7 May 2005 01:28:58 +1000 (EST)
Received: from d12nrmr1707.megacenter.de.ibm.com
	(d12nrmr1707.megacenter.de.ibm.com [9.149.167.81])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id j46FSsqF143700
	for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2005 15:28:54 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1707.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j46FSrct234954
	for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2005 17:28:53 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11/8.13.3) with ESMTP id
	j46FSrvK002083
	for <linuxppc-dev@ozlabs.org>; Fri, 6 May 2005 17:28:53 +0200
In-Reply-To: <20050506145313.GE1221@smtp.west.cox.net>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<466e699745cf24e660e296530f6e34dc@embeddededge.com>
	<17017.16478.767293.191940@cargo.ozlabs.ibm.com>
	<45e21c1ae2899849665fb894a2adcc20@embeddededge.com>
	<17017.39523.745634.193331@cargo.ozlabs.ibm.com>
	<20050505041225.GX1221@smtp.west.cox.net>
	<17017.42136.824607.253146@cargo.ozlabs.ibm.com>
	<20050505044737.GY1221@smtp.west.cox.net>
	<17017.44421.790813.918463@cargo.ozlabs.ibm.com>
	<205f4a46b0d9eddd5c46ff1678c9e4ca@kernel.crashing.org>
	<20050506145313.GE1221@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v622)
Message-Id: <037495ad1309ee55e6028a63fd279440@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Fri, 6 May 2005 17:28:57 +0200
To: Tom Rini <trini@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Note that up until very recently (and just a bit before conflicting
> opcodes were added), no -mcpu=XXX was required.

True, but it's just lucky that it worked...


Segher
