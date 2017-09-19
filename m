Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xx5rM1ZgjzDqF3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 12:08:19 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id m30so1207206pgn.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Sep 2017 19:08:19 -0700 (PDT)
Date: Tue, 19 Sep 2017 11:08:13 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "James E . J . Bottomley" <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] [RFC] printk/ia64/ppc64/parisc64: let's deprecate
 %pF/%pf printk specifiers
Message-ID: <20170919020812.GB16991@jagdpanzerIV.localdomain>
References: <20170916035347.19705-1-sergey.senozhatsky@gmail.com>
 <20170918174432.4fksyzco2g6gczwe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170918174432.4fksyzco2g6gczwe@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (09/18/17 10:44), Luck, Tony wrote:
[..]
> 
> A few new warnings when building on ia64:
> 
> arch/ia64/kernel/module.c:931: warning: passing argument 1 of 'dereference_function_descriptor' makes pointer from integer without a cast
> arch/ia64/kernel/module.c:931: warning: return makes integer from pointer without a cast
> kernel/kallsyms.c:325: warning: assignment makes integer from pointer without a cast
> kernel/kallsyms.c:325: warning: passing argument 1 of 'dereference_kernel_function_descriptor' makes pointer from integer without a cast

got it, will address in v2.

[..]
> Which looks like what you wanted. People unaware of the vagaries
> of ppc64/ia64/parisc64 can use the wrong %p[SF] variant, but still
> get the right output.

thanks!

	-ss
