Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHfgk4bcjzDqY1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 17:50:10 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id g6so6320084pgn.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 23:50:10 -0700 (PDT)
Date: Thu, 19 Oct 2017 15:50:04 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jessica Yu <jeyu@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/7] switch dereference_function_descriptor() to
 `unsigned long'
Message-ID: <20171019065004.GF449@jagdpanzerIV>
References: <20170930025319.987-1-sergey.senozhatsky@gmail.com>
 <20170930025319.987-2-sergey.senozhatsky@gmail.com>
 <20171004082414.GC20084@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171004082414.GC20084@pathway.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (10/04/17 10:24), Petr Mladek wrote:
[..]
> To make it clear. All these comments are not a big deal and I do
> not want to invalidate all the acked-by and tested-by just because
> of them.
>
> But please, consider removing this change if we need to do
> another iteration of this patchset. IMHO, there is no real win
> and it would just pollute the git history.

I tend to rather keep it. would that cause any problems on your side?
it saves a ton of ugly casts later in the patch set and lets us to drop
some casts from the modules code/etc. the patch is here because otherwise
I had to add a bunch of new casts.

	-ss
