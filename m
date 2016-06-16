Return-Path: <hekuang@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [58.251.152.64])
 by lists.ozlabs.org (Postfix) with ESMTP id 3rVR242zhkzDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 11:41:46 +1000 (AEST)
Subject: Re: [PATCH] tools/perf: fix the word selected in find_*_bit
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Yury Norov
 <ynorov@caviumnetworks.com>
References: <1465990973-31483-1-git-send-email-maddy@linux.vnet.ibm.com>
 <20160615195127.GA6039@yury-N73SV> <20160615211104.GA6978@yury-N73SV>
 <20160615212958.GC4882@kernel.org>
CC: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, "Adrian
 Hunter" <adrian.hunter@intel.com>,
 Borislav Petkov <bp@suse.de>, David Ahern <dsahern@gmail.com>,
 George Spelvin <linux@horizon.com>, Jiri Olsa <jolsa@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Wang Nan <wangnan0@huawei.com>, Yury Norov
 <yury.norov@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
From: Hekuang <hekuang@huawei.com>
Message-ID: <5762027C.2020507@huawei.com>
Date: Thu, 16 Jun 2016 09:35:56 +0800
MIME-Version: 1.0
In-Reply-To: <20160615212958.GC4882@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/6/16 5:29, Arnaldo Carvalho de Melo 写道:
> Em Thu, Jun 16, 2016 at 12:11:04AM +0300, Yury Norov escreveu:
>> On Wed, Jun 15, 2016 at 10:51:27PM +0300, Yury Norov wrote:
>>> Maybe there already is some macro doing the conversion for you...
>> yes it is, cpu_to_le64() is what you want
> Beware that the cpu_to_le64() in tools/perf is bogus, we need to grab a
> copy from the kernel sources.
>
> - Arnaldo
>
[PATCH 1/2] tools include: Sync byteorder/generic.h
[PATCH 2/2] tools include: Fix wrong macro definitions for cpu_to_le* 
for big endian

Here're two patches related to this issue, sorry for wrongly sent two more
reduntant mails.

Thank you.
