Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp3.wanadoo.fr (smtp3.wanadoo.fr [193.252.22.28])
	by ozlabs.org (Postfix) with ESMTP id 61C4F2BF0E
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jan 2005 23:25:32 +1100 (EST)
Date: Sun, 9 Jan 2005 13:35:15 +0100
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20050109123515.GC17561@pegasos>
References: <20050109115720.GA19213@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20050109115720.GA19213@lst.de>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: status of the G4 l2 cache flush and MSR errate patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 09, 2005 at 12:57:20PM +0100, Christoph Hellwig wrote:
> Sven & Ben,
> 
> what's the status of the patch below (forward-port to 2.6.10 by me)?
> 
> 
> 
> #! /bin/sh -e 
> ##
> ## All lines beginning with `## DP:' are a description of the patch.
> ## DP: Description: Fixes g4 l2 cache flush and MSR erratas.
> ## DP: Patch author: Sven Luther <luther@debian.org>

Mmm, well, i am not really the author of this one. Jacob Pan from freescale is
the author, so we should change this, will do. So this should show :

## DP: Patch author: Pan Jacob-r7aahq <Jacob.Pan@freescale.com>
> ## DP: Upstream status: under review by benh.

The patch does two things. Use hardware assist for cache flush, which seems to
be ok on 744x processors, but broken on earlier G4s and G3s. And add a printk
in case of some exception, so the user knows about it instead of it being
silently discarded. 

I was under the impression that benh said that the patch was ok, but not
really relevant, since it applies to code travel cases which either are not
really used in the common case, or result in a dying of the kernel anyway.
Don't remember all the details though. They do respond to some G4 processor
errata's though.

Friendly,

Sven Luther
