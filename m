Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w34Zq2J20zDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 23:31:47 +1000 (AEST)
In-Reply-To: <1491864507-16741-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/2] powerpc: Create asm/debugfs.h and move powerpc_debugfs_root
 there
Message-Id: <3w34Zq0W8Zz9sNZ@ozlabs.org>
Date: Wed, 12 Apr 2017 23:31:46 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-10 at 22:48:26 UTC, Michael Ellerman wrote:
> powerpc_debugfs_root is the dentry representing the root of the
> "powerpc" directory tree in debugfs.
> 
> Currently it sits in asm/debug.h, a long with some other things that
> have "debug" in the name, but are otherwise unrelated.
> 
> Pull it out into a separate header, which also includes linux/debugfs.h,
> and convert all the users to include debugfs.h instead of debug.h.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/7644d5819cf8956d799a0a0e5dc75f

cheers
