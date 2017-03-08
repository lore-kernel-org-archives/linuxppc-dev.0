Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdQ6g4V5VzDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 18:25:47 +1100 (AEDT)
In-Reply-To: <1486199020-59977-1-git-send-email-shile.zhang@nokia.com>
To: Shile Zhang <shile.zhang@nokia.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Shile Zhang <shile.zhang@nokia.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/64: Fix checksum folding in csum_add
Message-Id: <3vdQ6g3pbYz9sN6@ozlabs.org>
Date: Wed,  8 Mar 2017 18:25:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-02-04 at 09:03:40 UTC, Shile Zhang wrote:
> fix the missed point in Paul's patch:
> "powerpc/64: Fix checksum folding in csum_tcpudp_nofold and
> ip_fast_csum_nofold"
> 
> Signed-off-by: Shile Zhang <shile.zhang@nokia.com>
> Acked-by: Paul Mackerras <paulus@ozlabs.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/6ad966d7303b70165228dba1ee8da1

cheers
