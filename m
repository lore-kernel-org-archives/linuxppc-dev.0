Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AC65ADDDE3
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2008 23:47:02 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB4CkKnG006532
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 05:46:20 -0700
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB4CkvZ4226166
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 05:46:57 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB4CkusP030608
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2008 05:46:56 -0700
Date: Thu, 4 Dec 2008 07:46:53 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/3] powerpc: Split mmu_context handling
Message-ID: <20081204074653.0a8edf2d@zod.rchland.ibm.com>
In-Reply-To: <20081204054228.E8FE6DDE0F@ozlabs.org>
References: <20081204054228.E8FE6DDE0F@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 04 Dec 2008 16:41:48 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

Stephen had a bunch of comments as well, so I'll spare you those
again...

> Index: linux-work/arch/powerpc/mm/mmu_context_nohash.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ linux-work/arch/powerpc/mm/mmu_context_nohash.c	2008-12-03 13:50:18.000000000 +1100
> @@ -0,0 +1,168 @@
> +/*
> + * This file contains the routines for handling the MMU on those
> + * PowerPC implementations where the MMU substantially follows the
> + * architecture specification.  This includes the 6xx, 7xx, 7xxx,
> + * 8260, and POWER3 implementations but excludes the 8xx and 4xx.
> + *  -- paulus

..but I couldn't let this one go.  Totally incorrect comments here given
that the file is _for_ 8xx and 4xx. I suspect an errant copy/paste :).

josh
