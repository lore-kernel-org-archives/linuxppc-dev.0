Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EE55BDDF91
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 07:50:45 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBFKnV73020540
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2008 13:49:31 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBFKodoe176584
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2008 13:50:41 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBFKodnn026558
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Dec 2008 13:50:39 -0700
Date: Mon, 15 Dec 2008 15:50:32 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: update powerpc.git next and pull in some of benh's mmu patches
Message-ID: <20081215155032.5c00c281@zod.rchland.ibm.com>
In-Reply-To: <32B523EF-18CD-44BD-8B00-FEE38443B481@freescale.com>
References: <32B523EF-18CD-44BD-8B00-FEE38443B481@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 15 Dec 2008 14:44:12 -0600
Kumar Gala <kumar.gala@freescale.com> wrote:

> Pathces left up to Josh & Ben
> 
> 3/16 powerpc/4xx: Extended DCR support v2

I'd like to test this one a bit.

> 13/16 powerpc/44x: No need to mask MSR:CE, ME or DE in _tlbil_va on 440

This one should be good to go.  I already Acked it.

> 16/16 powerpc/44x: 44x TLB doesn't need "Guarded" set for all pages

Would like to test this one as well.

Also, could you look at Hollis' memory size alignment patch.  That is
needed for the large page stuff.

josh
