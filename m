Return-Path: <tony.luck@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yYSk52XkyzDrKr
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Nov 2017 05:10:04 +1100 (AEDT)
Date: Fri, 10 Nov 2017 10:09:32 -0800
From: "Luck, Tony" <tony.luck@intel.com>
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>, Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCHv4 5/6] symbol lookup: introduce
 dereference_symbol_descriptor()
Message-ID: <20171110180931.xhhi35osclzceba2@agluck-desk>
References: <20171109234830.5067-1-sergey.senozhatsky@gmail.com>
 <20171109234830.5067-6-sergey.senozhatsky@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171109234830.5067-6-sergey.senozhatsky@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 10, 2017 at 08:48:29AM +0900, Sergey Senozhatsky wrote:
> -Examples::
> -
> -	printk("Going to call: %pF\n", gettimeofday);
> -	printk("Going to call: %pF\n", p->func);
> -	printk("%s: called from %pS\n", __func__, (void *)_RET_IP_);
> -	printk("%s: called from %pS\n", __func__,
> -				(void *)__builtin_return_address(0));
> -	printk("Faulted at %pS\n", (void *)regs->ip);
> -	printk(" %s%pB\n", (reliable ? "" : "? "), (void *)*stack);

Did you mean to delete the Examples completely?  Wouldn't it
be better to just update (s/%pF/%pS/g)?

-Tony
