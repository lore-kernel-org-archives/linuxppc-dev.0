Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y25Jl72FgzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 15:01:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, "Luck\,
 Tony" <tony.luck@intel.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Santosh Sivaraj <santosh@fossix.org>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, "Yu\,
 Fenghua" <fenghua.yu@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, James Bottomley <jejb@parisc-linux.org>,
 Helge Deller <deller@gmx.de>, Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 "linux-ia64\@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-parisc\@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 0/7] printk/ia64/ppc64/parisc64: let's deprecate
 %pF/%pf printk specifiers
In-Reply-To: <20170925070542.GA387@jagdpanzerIV.localdomain>
References: <20170920162910.32053-1-sergey.senozhatsky@gmail.com>
 <20170922053404.3zpfpwetabjut2er@santosiv.in.ibm.com>
 <20170922080023.GA599@jagdpanzerIV.localdomain>
 <3908561D78D1C84285E8C5FCA982C28F61381992@ORSMSX114.amr.corp.intel.com>
 <20170925070542.GA387@jagdpanzerIV.localdomain>
Date: Wed, 27 Sep 2017 15:01:43 +1000
Message-ID: <871smsg2fc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> writes:

> On (09/22/17 16:48), Luck, Tony wrote:
> [..]
>> Tested patch series on ia64 successfully.
>> 
>> Tested-by: Tony Luck <tony.luck@intel.com>
>
> thanks!
>
>> After this goes upstream, you should submit a patch to get rid of
>> all uses of %pF (70 instances in 35 files) and %pf (63 in 34)
>> 
>> Perhaps break the patch by top-level directory (e.g. get all the %pF
>> and %pF in the 17 files under drivers/ in one patch).
>
> frankly, I was going to have some sort of a lazy deprecation process:
> didn't plan to send out a patch set that would hunt down all pf/pF-s.
> hm...

That never works though, we have lots of cruft left over from times when
that's happened and the conversion never quite got finished.

At least if you send out the patches to do the removal they might
eventually get merged.

> speaking of upstream, any objections if this patch set will go through
> the printk tree, in one piece?

Do you mind putting it in a topic branch (based on rc2) and then merge
that into the printk tree? That way I can merge the topic branch iff
there are conflicts later down the line towards 4.15.

cheers
