Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLF0J7rzDqT0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:05 +1000 (AEST)
In-Reply-To: <1498573791-6781-1-git-send-email-hare@suse.de>
To: Hannes Reinecke <hare@suse.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Hannes Reinecke <hare@suse.com>, linuxppc-dev@lists.ozlabs.org,
 Hannes Reinecke <hare@suse.de>, Torsten Duwe <duwe@suse.com>
Subject: Re: powerpc: conditionally compile platform-specific serial drivers
Message-Id: <3xjgLD6XBkz9t2Q@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:02 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-06-27 at 14:29:51 UTC, Hannes Reinecke wrote:
> mpsc.c and mpc52xx-psc.c are platform-specific serial drivers, and
> should be compiled for the respective platforms only.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Torsten Duwe <duwe@suse.de>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/866bfc75f40e4f8a00d268f73f3a02

cheers
