Return-Path: <pmladek@suse.com>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD35F1A15DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jan 2016 01:17:41 +1100 (AEDT)
Date: Wed, 6 Jan 2016 15:17:30 +0100
From: Petr Mladek <pmladek@suse.com>
To: Torsten Duwe <duwe@lst.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org
Subject: Re: [PATCH v5 0/9] ftrace with regs + live patching for ppc64 LE
 (ABI v2)
Message-ID: <20160106141730.GL3178@pathway.suse.cz>
References: <20151204152419.28E0D691D2@newverein.lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151204152419.28E0D691D2@newverein.lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri 2015-12-04 15:45:29, Torsten Duwe wrote:
> Changes since v4:
>   * change comment style in entry_64.S to C89
>     (nobody is using assembler syntax comments there).
>   * the bool function restore_r2 shouldn't return 2,
>     that's a little confusing.
>   * Test whether the compiler supports -mprofile-kernel
>     and only then define CC_USING_MPROFILE_KERNEL
>   * also make the return value of klp_check_compiler_support
>     depend on that.

Note that there is still needed the extra patch from
http://thread.gmane.org/gmane.linux.kernel/2093867/focus=2099603
to get the livepatching working.

Both ftrace with regs and live patching works for me with this patch
set and the extra patch. So. for the whole patchset:

Tested-by: Petr Mladek <pmladek@suse.com>


Best Regards,
Petr
