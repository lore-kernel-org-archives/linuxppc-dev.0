Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RGF4npRzDqhw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:27:49 +1100 (AEDT)
In-Reply-To: <20180225172236.29650-3-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [02/21] powerpc: Move the inline keyword at the beginning of
 function declaration
Message-Id: <401RGF3db0z9sVP@ozlabs.org>
Date: Wed, 14 Mar 2018 20:27:48 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2018-02-25 at 17:22:17 UTC, Mathieu Malaterre wrote:
> The inline keyword was not at the beginning of the function declaration.
> Fix the following warning (treated as error in W=1)
> 
>   CC      kernel/sys.o
> arch/powerpc/lib/sstep.c:283:1: error: ‘inline’ is not at beginning of declaration [-Werror=old-style-declaration]
>  static int nokprobe_inline copy_mem_in(u8 *dest, unsigned long ea, int nb,
>  ^~~~~~
> arch/powerpc/lib/sstep.c:388:1: error: ‘inline’ is not at beginning of declaration [-Werror=old-style-declaration]
>  static int nokprobe_inline copy_mem_out(u8 *dest, unsigned long ea, int nb,
>  ^~~~~~
>   CC      arch/powerpc/kernel/setup_32.o
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/174b701d3dcd14514f869e2bc08ac4

cheers
