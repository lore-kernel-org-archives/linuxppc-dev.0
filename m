Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CC881DEB3D
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Apr 2008 02:25:45 +1000 (EST)
Message-Id: <B1DC8A71-174F-48E2-A61B-8D98984F10AD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: benh@kernel.crashing.org
In-Reply-To: <1209048813.9060.192.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [RFC][WIP][PATCH] Add IRQSTACKS to ppc32
Date: Thu, 24 Apr 2008 11:25:38 -0500
References: <Pine.LNX.4.64.0804240034160.23185@blarg.am.freescale.net>
	<1209021537.9060.156.camel@pasglop>
	<43F83C6F-D84B-4626-8974-9BCEDF03194E@kernel.crashing.org>
	<1209048813.9060.192.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 24, 2008, at 9:53 AM, Benjamin Herrenschmidt wrote:
>
> On Thu, 2008-04-24 at 07:59 -0500, Kumar Gala wrote:
>> I'm going to change it to be just lmb_alloc() so it will be difficult
>> to share with ppc64 (other than w/an ifdef).
>
> Unless we change lmb_alloc to just be an lmb_alloc_base with 0 and  
> have
> the later do the right thing ?

don't follow.  Look at the "real" patch and comment on that.

> You don't put highmem in the LMBs ? If you do, we do need to have the
> max lowmem there no ?

we restrict lmb alloc via LMB_REAL_LIMIT in include/asm-powerpc/lmb.h

- k
