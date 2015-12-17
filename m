Return-Path: <wangnan0@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [58.251.152.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC9301A11B7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 17:02:40 +1100 (AEDT)
Message-ID: <56724FD7.8050804@huawei.com>
Date: Thu, 17 Dec 2015 14:01:59 +0800
From: "Wangnan (F)" <wangnan0@huawei.com>
MIME-Version: 1.0
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
CC: <acme@kernel.org>, <jolsa@redhat.com>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <sukadev@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v4 2/3] tools: Move Makefile.arch from perf/config
 to tools/scripts
References: <1450316632-152513-1-git-send-email-wangnan0@huawei.com>
 <1450316632-152513-3-git-send-email-wangnan0@huawei.com>
 <20151217051028.GC21524@naverao1-tp.ibm.com>
In-Reply-To: <20151217051028.GC21524@naverao1-tp.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 2015/12/17 13:10, Naveen N. Rao wrote:
> On 2015/12/17 01:43AM, Wang Nan wrote:
>> After this patch other directories can use this architecture detector
>> without directly including it from perf's directory. Libbpf would
>> utilize it to get proper $(ARCH) so it can receive correct uapi include
>> directory.
>>
>> Signed-off-by: Wang Nan <wangnan0@huawei.com>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>> Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
>> ---
>>   tools/perf/config/Makefile      |  2 +-
>>   tools/perf/config/Makefile.arch | 18 ------------------
>>   tools/perf/tests/make           |  2 +-
>>   tools/scripts/Makefile.arch     | 18 ++++++++++++++++++
>>   4 files changed, 20 insertions(+), 20 deletions(-)
>>   delete mode 100644 tools/perf/config/Makefile.arch
>>   create mode 100644 tools/scripts/Makefile.arch
>     ^^^^^^
> This is different from your previous version. This should be a file
> rename.

Forget to use git format -M. The content is identical. Should I send it 
again?

Thank you.
