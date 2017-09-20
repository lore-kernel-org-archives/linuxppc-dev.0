Return-Path: <deller@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xy6nf6myDzDqXy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 03:54:30 +1000 (AEST)
Subject: Re: [RFC][PATCH v2 7/7] checkpatch: add pF/pf deprecation warning
To: Joe Perches <joe@perches.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 James Bottomley <jejb@parisc-linux.org>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
References: <20170920162910.32053-1-sergey.senozhatsky@gmail.com>
 <20170920162910.32053-8-sergey.senozhatsky@gmail.com>
 <1505929138.12311.5.camel@perches.com>
From: Helge Deller <deller@gmx.de>
Message-ID: <ddf9b54b-34d9-c1e2-e34f-a1cc055b8cf7@gmx.de>
Date: Wed, 20 Sep 2017 19:53:49 +0200
MIME-Version: 1.0
In-Reply-To: <1505929138.12311.5.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20.09.2017 19:38, Joe Perches wrote:
> On Thu, 2017-09-21 at 01:29 +0900, Sergey Senozhatsky wrote:
>> We deprecated '%pF/%pf' printk specifiers, since '%pS/%ps' is now smart
>> enough to handle function pointer dereference on platforms where such
>> dereference is required.
>>
>> checkpatch warning example:
>>
>> WARNING: Use '%pS/%ps' instead. This pointer extension was deprecated: '%pF'
> 
> If this series is accepted,  I think this message
> is unclear and would prefer something like:

Is it worth to mention, that it's still needed in older kernels?
Just in case some patch get's backported.

Helge
