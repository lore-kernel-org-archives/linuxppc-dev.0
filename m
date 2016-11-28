Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tS5Gn6kvxzDt3c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 23:15:13 +1100 (AEDT)
In-Reply-To: <1446776477-2604-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: rostedt@goodmis.org
Subject: Re: powerpc/xmon: Add 'dt' command to dump trace buffers
Message-Id: <3tS5Gn5hd1z9vFX@ozlabs.org>
Date: Mon, 28 Nov 2016 23:15:13 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-11-06 at 02:21:17 UTC, Michael Ellerman wrote:
> There is a nice interface for asking ftrace to dump all its tracing
> buffers. The only down side for use in xmon is that it uses printk.
> Depending on circumstances printk may not work when in xmon, but it also
> may, so add a 'dt' command which dumps the ftrace buffers, and add a
> note to the help to mentiont that it uses printk.
> 
> Calling this routine also disables tracing, which is problematic if you
> return from xmon and expect the system to keep operating normally. So
> after we do the dump turn tracing back on.
> 
> Both functions already have nop versions defined for when ftrace is not
> enabled, so we don't need any extra #ifdefs.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/56144ec7c93f6f18aa878560074633

cheers
