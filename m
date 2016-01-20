Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E86A1A0FCC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 17:03:24 +1100 (AEDT)
Message-ID: <1453269803.14751.10.camel@ellerman.id.au>
Subject: Re: [PATCH v5 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Petr Mladek <pmladek@suse.com>, Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Kosina <jkosina@suse.cz>,
 Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,  live-patching@vger.kernel.org
Date: Wed, 20 Jan 2016 17:03:23 +1100
In-Reply-To: <20160106141730.GL3178@pathway.suse.cz>
References: <20151204152419.28E0D691D2@newverein.lst.de>
 <20160106141730.GL3178@pathway.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-01-06 at 15:17 +0100, Petr Mladek wrote:
> On Fri 2015-12-04 15:45:29, Torsten Duwe wrote:
> > Changes since v4:
> >   * change comment style in entry_64.S to C89
> >     (nobody is using assembler syntax comments there).
> >   * the bool function restore_r2 shouldn't return 2,
> >     that's a little confusing.
> >   * Test whether the compiler supports -mprofile-kernel
> >     and only then define CC_USING_MPROFILE_KERNEL
> >   * also make the return value of klp_check_compiler_support
> >     depend on that.
>
> Note that there is still needed the extra patch from
> http://thread.gmane.org/gmane.linux.kernel/2093867/focus=2099603
> to get the livepatching working.

Sorry which extra patch?

> Both ftrace with regs and live patching works for me with this patch
> set and the extra patch. So. for the whole patchset:
>
> Tested-by: Petr Mladek <pmladek@suse.com>

Can you give me some more info on how you're testing it? What config options,
toolchain etc.?

For me the series doesn't even boot, even with livepatching disabled.

cheers
