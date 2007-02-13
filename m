Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AC156DDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 02:03:56 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1DF3qTs003188
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 10:03:52 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1DF3qtM503574
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 08:03:52 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1DF3lqD011546
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 08:03:47 -0700
Subject: Re: [PATCH 7/16] Early serial debug support for PPC44x
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070213061024.DA1ABDDD0C@ozlabs.org>
References: <20070213061024.DA1ABDDD0C@ozlabs.org>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 09:04:47 -0600
Message-Id: <1171379087.4003.40.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-13 at 17:10 +1100, David Gibson wrote:
> This patch adds support for early serial debugging via the built in
> port on IBM/AMCC PowerPC 44x CPUs.  It uses a bolted TLB entry in
> address space 1 for the UART's mapping, allowing robust debugging both
> before and after the initialization of the MMU.

When enabling this option, I get the following error:

 AS      arch/powerpc/kernel/head_44x.o
arch/powerpc/kernel/head_44x.S: Assembler messages:
arch/powerpc/kernel/head_44x.S:179: Warning: left operand is a bignum;
integer 0 assumed
arch/powerpc/kernel/head_44x.S:183: Error: bignum invalid
arch/powerpc/kernel/head_44x.S:184: Warning: left operand is a bignum;
integer 0 assumed
make[1]: *** [arch/powerpc/kernel/head_44x.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

josh
