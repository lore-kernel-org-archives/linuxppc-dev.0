Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 715951A0331
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 23:16:06 +1100 (AEDT)
In-Reply-To: <1450124286-4822-2-git-send-email-kda@linux-powerpc.org>
To: Denis Kirjanov <kda@linux-powerpc.org>,
 Steven Rostedt <rostedt@goodmis.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Denis Kirjanov <kda@linux-powerpc.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [v3,2/2] powerpc: tracing: don't trace hcalls on offline CPUs
Message-Id: <20160209121606.3D7AC140B9A@ozlabs.org>
Date: Tue,  9 Feb 2016 23:16:06 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-14-12 at 20:18:06 UTC, Denis Kirjanov wrote:
> ./drmgr -c cpu -a -r gives the following warning:
> 
> ...

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/168a20bb35122539682671d15c

cheers
