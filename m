Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vvgsg0km6zDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 23:33:59 +1100 (AEDT)
In-Reply-To: <20170327193233.25147-1-cascardo@canonical.com>
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [v2] powerpc: make /proc/self/stack always print the current stack
Message-Id: <3vvgsf6Y16z9s4s@ozlabs.org>
Date: Fri, 31 Mar 2017 23:33:58 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-03-27 at 19:32:33 UTC, Thadeu Lima de Souza Cascardo wrote:
> For the current task, the kernel stack would only tell the last time the
> process was rescheduled, if ever. Use the current stack pointer for the
> current task.
> 
> Otherwise, every once in a while, the stacktrace printed when reading
> /proc/self/stack would look like the process is running in userspace,
> while it's not, which some may consider as a bug.
> 
> This is also consistent with some other architectures, like x86 and arm,
> at least.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/4f9b514b765a3057341f3236c94877

cheers
