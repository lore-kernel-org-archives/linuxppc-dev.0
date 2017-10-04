Return-Path: <pmladek@suse.com>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y6ZSQ564rzDqpt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 23:08:53 +1100 (AEDT)
Date: Wed, 4 Oct 2017 14:08:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCHv3 7/7] checkpatch: add pF/pf deprecation warning
Message-ID: <20171004120847.GI20084@pathway.suse.cz>
References: <20170930025319.987-1-sergey.senozhatsky@gmail.com>
 <20170930025319.987-8-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170930025319.987-8-sergey.senozhatsky@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat 2017-09-30 11:53:19, Sergey Senozhatsky wrote:
> We deprecated '%pF/%pf' printk specifiers, since '%pS/%ps' is now smart
> enough to handle function pointer dereference on platforms where such
> dereference is required.
> 
> checkpatch warning example:
> 
> WARNING: Deprecated vsprintf pointer extension '%pF' - use %pS instead
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> Cc: Andy Whitcroft <apw@canonical.com>
> Tested-by: Helge Deller <deller@gmx.de> # parisc64
> Tested-by: Santosh Sivaraj <santosh@fossix.org> # powerpc64
> Acked-by: Michael Ellerman <mpe@ellerman.id.au> # powerpc64
> Tested-by: Tony Luck <tony.luck@intel.com> # ia64

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
