Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9316A1A0743
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 20:45:56 +1100 (AEDT)
In-Reply-To: <20160201170325.4ec4324e@cotter.ozlabs.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: kgdb-bugreport@lists.sourceforge.net, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Fix kgdb on little endian ppc64le
Message-Id: <20160222094556.786E2140C42@ozlabs.org>
Date: Mon, 22 Feb 2016 20:45:56 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-01-02 at 06:03:25 UTC, Balbir Singh wrote:
> From: Balbir Singh <bsingharora@gmail.com>
> 
> I spent some time trying to use kgdb and debugged my inability to
> resume from kgdb_handle_breakpoint(). NIP is not incremented
> and that leads to a loop in the debugger.
> 
> I've tested this lightly on a virtual instance with KDB enabled.
> After the patch, I am able to get the "go" command to work as
> expected
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/94e3d923592fcfe5585c18a0af

cheers
