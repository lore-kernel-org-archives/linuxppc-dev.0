Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zvzsn5FJZzF0R7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Mar 2018 23:36:13 +1100 (AEDT)
In-Reply-To: <20180226021926.32513-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: gromero@linux.vnet.ibm.com
Subject: Re: selftests/powerpc: Skip tm-trap if transactional memory is not
 enabled
Message-Id: <3zvzsl4bxwz9sZj@ozlabs.org>
Date: Mon,  5 Mar 2018 23:36:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-02-26 at 02:19:26 UTC, Michael Ellerman wrote:
> Some processor revisions do not support transactional memory, and
> additionally kernel support can be disabled. In either case the
> tm-trap test should be skipped, otherwise it will fail with a SIGILL.
> 
> Fixes: a08082f8e4e1 ("powerpc/selftests: Check endianness on trap in TM")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/192b2e742c06af399e8eecb4a17265

cheers
