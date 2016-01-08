Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 35BA01A01E3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jan 2016 00:46:14 +1100 (AEDT)
Date: Fri, 8 Jan 2016 10:46:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Wangnan (F)" <wangnan0@huawei.com>, Fengguang Wu <fengguang.wu@intel.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Jiri Olsa <jolsa@kernel.org>,
 linux-kernel@vger.kernel.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH v4] perf: bpf: Fix build breakage due to libbpf
Message-ID: <20160108134608.GF19314@kernel.org>
References: <20151215114046.GG23726@naverao1-tp.in.ibm.com>
 <20151216194234.GA19926@kernel.org> <56720FFB.5060407@huawei.com>
 <20151217050714.GB21524@naverao1-tp.ibm.com>
 <20151217121939.GH19926@kernel.org>
 <20160107065709.GA2459@naverao1-tp.ibm.com>
 <20160107203957.GG18457@kernel.org>
 <20160108053854.GB2459@naverao1-tp.ibm.com>
 <20160108125157.GC19314@kernel.org> <568FBA42.3030006@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <568FBA42.3030006@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Fri, Jan 08, 2016 at 09:31:46PM +0800, Wangnan (F) escreveu:
> On 2016/1/8 20:51, Arnaldo Carvalho de Melo wrote:
> >Em Fri, Jan 08, 2016 at 11:09:35AM +0530, Naveen N. Rao escreveu:
> >>On 2016/01/07 05:39PM, Arnaldo Carvalho de Melo wrote:
> >>>Em Thu, Jan 07, 2016 at 12:28:15PM +0530, Naveen N. Rao escreveu:
> >>>>On 2015/12/17 09:19AM, Arnaldo Carvalho de Melo wrote:
> >>>>>Em Thu, Dec 17, 2015 at 10:37:14AM +0530, Naveen N. Rao escreveu:
> >>>>Arnaldo,
> >>>>Can you please push at least the initial 3 patches of this for v4.4?
> >>>>Wang Nan has posted v6 here:
> >>>>http://thread.gmane.org/gmane.linux.kernel/2110626
> >>>So I tried it again today, from the v6, the latest patch with that
> >>>subject line in my inbox, and I get this, after applying the first three
> >>>patches:

> >>>$ make -C tools clean > /dev/null
> >>>$ make -C tools/perf build-test
> >>Thanks, and sorry for the slip-up there - I should've caught that.
> >The important thing is that it gets caught before getting to Ingo, let
> >alone Linus, but if you get it before me, I'd appreciate as well 8-)
 
> Is it possible to ask Fengguang Wu to help us adding perf building test
> in his kbuild testing system?

I was thinking about this yesterday, when, IIRC, a change made by Kan
Liang (IIRC) to a kernel/events/ file, in the kernel proper, triggered a
warning about some casts and I got a warning, since I was in the commig
log CC list.

Since perf is in the kernel sources, and since we have the 'make -C
tools/perf build-test' harness, that would be really great to have it
hooked into the 0day bot...
 
> Add Fengguang Wu into cc list.
> 
> Thank you.

Thanks!

- Arnaldo
