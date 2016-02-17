Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FB031A0342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:41:29 +1100 (AEDT)
In-Reply-To: <1448290875-20896-2-git-send-email-dougmill@linux.vnet.ibm.com>
To: Douglas Miller <dougmill@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc/xmon: Add xmon command to dump process/task similar to
 ps(1)
Message-Id: <20160217124129.23C97140784@ozlabs.org>
Date: Wed, 17 Feb 2016 23:41:28 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-23-11 at 15:01:15 UTC, Douglas Miller wrote:
> Add 'P' command with optional task_struct address to dump all/one task's
> information: task pointer, kernel stack pointer, PID, PPID, state
> (interpreted), CPU where (last) running, and command.
> 
> Introduce XMON_PROTECT macro to standardize memory-access-fault
> protection (setjmp). Initially used only by the 'P' command.
> 
> Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6dfb54049f9a99b24fe5d5cd2d

cheers
