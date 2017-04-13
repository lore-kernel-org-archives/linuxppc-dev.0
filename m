Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3dh86W4nzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 21:23:20 +1000 (AEST)
In-Reply-To: <20170412063519.18560-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/syscalls/trace: Fix mmap in syscalls_trace
Message-Id: <3w3dh85gjtz9sNj@ozlabs.org>
Date: Thu, 13 Apr 2017 21:23:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-12 at 06:35:19 UTC, Balbir Singh wrote:
> This patch uses SYSCALL_DEFINE6 for sys_mmap and sys_mmap2
> so that the meta-data associated with these syscalls is
> visible to the syscall tracer. In the absence of this
> generic syscalls (defined outside arch) like munmap,etc.
> are visible in available_events, syscall_enter_mmap and
> syscall_exit_mmap is not.
> 
> A side-effect of this change is that the return type has
> changed from unsigned long to long.
...
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9c355917fcf006af47ffaa5ae43a1a

cheers
