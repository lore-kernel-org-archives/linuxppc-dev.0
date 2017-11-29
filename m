Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymsW53jGDzDr8x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 18:25:05 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id e14so1121274pgr.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 23:25:05 -0800 (PST)
Date: Wed, 29 Nov 2017 16:24:58 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Helge Deller <deller@gmx.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCHv4 0/6] printk/ia64/ppc64/parisc64: let's deprecate
 %pF/%pf printk specifiers
Message-ID: <20171129072458.GA468@jagdpanzerIV>
References: <20171109234830.5067-1-sergey.senozhatsky@gmail.com>
 <20171128154710.ytqixlioc3hrcbl3@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171128154710.ytqixlioc3hrcbl3@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (11/28/17 16:47), Petr Mladek wrote:
> On Fri 2017-11-10 08:48:24, Sergey Senozhatsky wrote:
> > 	Hello,
> > 
> > 	A reworked version. There is a new dereference_symbol_descriptor()
> > function now, where "the magic happens", so I don't touch kallsyms_lookup()
> > and module_address_lookup() anymore.
> 
> The new version looks good to me. Thanks a lot for reworking it.
> I feel much better now. For the whole series:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> > 	All Ack-s/Tested-by-s were dropped, since the patch set has been
> > reworked. I'm kindly asking arch-s maintainers and developers to test it
> > once again. Sorry for any inconveniences and thanks for your help in
> > advance.
> 
> I see that it was tested on all affected architectures. Thanks a lot
> all testers.
> 
> It seems that we are ready to go. I am going to push this into
> for-4.16 branch in printk.git.

thanks.

	-ss
