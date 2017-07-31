Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLV3J4Ds3zDrJh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 16:31:40 +1000 (AEST)
In-Reply-To: <1500443053-1264-1-git-send-email-gromero@linux.vnet.ibm.com>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: cyrilbur@gmail.com, Gustavo Romero <gromero@linux.vnet.ibm.com>
Subject: Re: powerpc/tm: fix TM SPRs in code dump file
Message-Id: <3xLV3J3Yrjz9tW3@ozlabs.org>
Date: Mon, 31 Jul 2017 16:31:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-19 at 05:44:13 UTC, Gustavo Romero wrote:
> Currently flush_tmregs_to_thread() does not update accordingly the thread
> structures from live state before a core dump rendering wrong values of
> THFAR, TFIAR, and TEXASR in core dump files.
> 
> That commit fixes it by copying from live state to the appropriate thread
> structures when it's necessary.
> 
> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
> Reviewed-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/cd63f3cf1d59b7ad8419eba1cac8f9

cheers
