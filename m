Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gMsc03DCzF14y
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 00:52:36 +1000 (AEST)
In-Reply-To: <20180327042906.32461-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: naveen.n.rao@linux.vnet.ibm.com, rostedt@goodmis.org
Subject: Re: powerpc: Only support DYNAMIC_FTRACE not static
Message-Id: <40gMsb2xC7z9s2k@ozlabs.org>
Date: Wed,  9 May 2018 00:52:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-03-27 at 04:29:06 UTC, Michael Ellerman wrote:
> We've had dynamic ftrace support for over 9 years since Steve first
> wrote it, all the distros use dynamic, and static is basically
> untested these days, so drop support for static ftrace.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/0c0c52306f4792a41d8a86e7c5d30c

cheers
