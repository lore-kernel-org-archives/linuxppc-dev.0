Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C1121A040B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 23:16:00 +1100 (AEDT)
In-Reply-To: <1447913093-28342-1-git-send-email-rashmicy@gmail.com>
To: Rashmica Gupta <rashmicy@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Standardise on NR_syscalls rather than __NR_syscalls.
Message-Id: <20151126121600.27D20140319@ozlabs.org>
Date: Thu, 26 Nov 2015 23:15:59 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-19-11 at 06:04:53 UTC, Rashmica Gupta wrote:
> Most architectures use NR_syscalls as the #define for the number of syscalls.
> 
> We use __NR_syscalls, and then define NR_syscalls as __NR_syscalls.
> 
> __NR_syscalls is not used outside arch code, whereas NR_syscalls is. So as
> NR_syscalls must be defined and __NR_syscalls does not, replace __NR_syscalls
> with NR_syscalls.
> 
> Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f43194e45852b0455d2a3e37

cheers
