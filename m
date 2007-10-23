Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D05BBDDFBD
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:27:50 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9NFRhno027201
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 11:27:43 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9NFRgR0105488
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 09:27:42 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9NFRg8t012377
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 09:27:42 -0600
Date: Tue, 23 Oct 2007 10:27:40 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Bugfix to commit 18dabf473e15850c0dbc8ff13ac1e2806d542c15
Message-ID: <20071023102740.72b372ae@weaponx.rchland.ibm.com>
In-Reply-To: <20071023151929.12090.3835.stgit@trillian.cg.shawcable.net>
References: <20071023151929.12090.3835.stgit@trillian.cg.shawcable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "Axboe <jens.axboe"@oracle.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	Linus Torvalds <torvalds@linux-foundation.org>, Jens@secretlab.ca
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 23 Oct 2007 09:20:25 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Fixup for commit 18dabf473e15850c0dbc8ff13ac1e2806d542c15.  Changes to
> dma_map_sg where done in asm-x86/dma-mapping_32.h, but were not mirrored
> in include/asm-powerpc/dma-mapping.h
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> Linus, I cannot build an arch/powerpc kernel without this patch.

Olof Johansson already sent a patch out for this that had some other
fixes in it.  I think Jens already applied it to his tree.

josh
