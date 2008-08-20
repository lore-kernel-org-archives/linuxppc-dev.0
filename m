Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D0F03DE079
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 03:11:31 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7KHBQ8i021305
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:11:26 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7KHBPdQ241508
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:11:25 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7KHBPVB023848
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:11:25 -0400
Date: Wed, 20 Aug 2008 13:11:24 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [PATCH 1/9] powerpc/44x: Add PowerPC 44x simple platform support
Message-ID: <20080820131124.05cfee9f@zod.rchland.ibm.com>
In-Reply-To: <adak5ebpry5.fsf@cisco.com>
References: <cover.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<496103659f7b122a8301703b055ef4c6bd3092af.1219160188.git.jwboyer@linux.vnet.ibm.com>
	<200808201533.22258.arnd@arndb.de>
	<fa686aa40808200715x6c850593p5655d8b5b8e7b61e@mail.gmail.com>
	<1219243548.26429.25.camel@jdub.homelinux.org>
	<adak5ebpry5.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Bergmann <arnd@arndb.de>, Arnd
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 20 Aug 2008 09:33:06 -0700
Roland Dreier <rdreier@cisco.com> wrote:

>  > You should fix 52xx with the same for loop change then, since I
>  > blatantly most of this file from you ;)
> 
> Heh, then factor out mpc5200_simple_probe() into a helper and use it
> instead of copying it as ppc44x_probe?  ;)
> 
> If you stick to the NULL-terminated array version, then it becomes easy
> to convert some other platform probing code to use your new code too, eg
> tqm85xx_probe() could use an array too.

Except that logically doesn't make much sense.  Why would you have a
list of mpc52xx and 44x boards together?  They require completely
different kernels because the MMU and drive set is entirely different.

Or am I totally missing what you are saying?

josh
