Return-Path: <hekuang@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [58.251.152.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW3H55kQTzDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 11:55:13 +1000 (AEST)
Subject: Re: [PATCH v2 1/2] tools include: Adopt byte ordering macros from
 byteorder/generic.h
To: Jiri Olsa <jolsa@redhat.com>
References: <1466073692-88702-1-git-send-email-hekuang@huawei.com>
 <20160616113600.GB20646@krava>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
 <alexander.shishkin@linux.intel.com>, <wangnan0@huawei.com>,
 <adrian.hunter@intel.com>, <ak@linux.intel.com>,
 <maddy@linux.vnet.ibm.com>, <bp@suse.de>, <dsahern@gmail.com>,
 <linux@horizon.com>, <namhyung@kernel.org>, <linux@rasmusvillemoes.dk>,
 <yury.norov@gmail.com>, <mpe@ellerman.id.au>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
From: Hekuang <hekuang@huawei.com>
Message-ID: <57635752.6020201@huawei.com>
Date: Fri, 17 Jun 2016 09:50:10 +0800
MIME-Version: 1.0
In-Reply-To: <20160616113600.GB20646@krava>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



在 2016/6/16 19:36, Jiri Olsa 写道:
> On Thu, Jun 16, 2016 at 10:41:31AM +0000, He Kuang wrote:
>> From: Wang Nan <wangnan0@huawei.com>
>>
>> This patch adopts the macros for byte order conversion from
>> "include/linux/byteorder/generic.h" to
>> "tools/include/linux/byteorder/generic.h"
>>
>> tools/perf/MANIFEST is also updated for 'make perf-*-src-pkg'.
> other than explanation for the kbuild test robot email:
>    http://marc.info/?l=linux-kernel&m=146605819924421&w=2
I think that's because of yesterday I sent these two patches
separately while the second one deponds on the first.

Thank you.
>
> it looks ok..
>
> jirka
>
