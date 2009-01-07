Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C30E5DDF82
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 01:37:01 +1100 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n07EZhXZ029963
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 09:35:43 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n07EarAo1277954
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 09:36:53 -0500
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n07EaqpS014547
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Jan 2009 07:36:52 -0700
Date: Wed, 7 Jan 2009 09:36:39 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
Subject: Re: Building current git for 405 is broken
Message-ID: <20090107143639.GE17171@zod.rchland.ibm.com>
References: <200901071510.45923.matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200901071510.45923.matthias.fuchs@esd-electronics.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 07, 2009 at 03:10:45PM +0100, Matthias Fuchs wrote:
>Hi Benjamin,
>
>commit 2a4aca114439 (powerpc/mm: Split low level tlb invalidate for nohash processors)
>breaks building for 40x CPUs. This is what I get when building for the walnut board:
>
>  CC      arch/powerpc/kernel/prom.o
>In file included from arch/powerpc/kernel/prom.c:56:
>arch/powerpc/mm/mmu_decl.h: In function '_tlbil_all':
>arch/powerpc/mm/mmu_decl.h:34: error: expected ';' before '}' token
>arch/powerpc/mm/mmu_decl.h:36: error: invalid storage class for function '_tlbil_pid'
>arch/powerpc/mm/mmu_decl.h: In function '_tlbil_pid':
>arch/powerpc/mm/mmu_decl.h:38: error: expected ';' before '}' token
>arch/powerpc/mm/mmu_decl.h:53: warning: ISO C90 forbids mixed declarations and code
>arch/powerpc/mm/mmu_decl.h:62: error: invalid storage class for function '_tlbivax_bcast'
>arch/powerpc/kernel/prom.c:90: error: invalid storage class for function 'find_flat_dt_string'
>
>Seems to be a result of some missing types or whatever. I suppose you are 
>more familiar with that code than I am ;-)

He sent a patch to fix this last night.

josh
