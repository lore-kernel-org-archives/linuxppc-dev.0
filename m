Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AF22DB7CEE
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 05:42:10 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1AIchuJ030356
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 11:38:43 -0700
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1AIfq86093600
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 11:41:54 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o1AIfnjY006348
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 11:41:49 -0700
Date: Wed, 10 Feb 2010 13:41:41 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Use lwarx hint bit in spinlocks
Message-ID: <20100210184141.GC16178@zod.rchland.ibm.com>
References: <20100210025010.GC3702@kryten>
	<20100210031923.GB16178@zod.rchland.ibm.com>
	<3941DE04-15C3-4E44-9278-923E874FE23E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3941DE04-15C3-4E44-9278-923E874FE23E@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 10, 2010 at 09:40:34AM -0600, Kumar Gala wrote:
>> In the off chance that someone actually does an SMP 44x, I think the hint bit
>> here would just be ignored (I could test possibly if we want to verify).
>> However, I thought the FSL parts didn't like toggling the reserved bits and
>> those already are SMP in some cases.
>> 
>> Kumar?
>> 
>> josh
>
>Yeah, I need to test this on some older SMP parts that didn't treated reserved bits being set in the opcode as ignored but illegal.

It looks like Anton just did a v2 of the patch targeted at ppc64 instead.

josh
