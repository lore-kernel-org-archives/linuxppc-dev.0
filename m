Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 24D492C0081
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 11:44:19 +1100 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 1E99F3EE0C0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 09:44:15 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 06B8945DEB5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 09:44:15 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id E332345DEB2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 09:44:14 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id D4A4B1DB803B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 09:44:14 +0900 (JST)
Received: from g01jpexchkw02.g01.fujitsu.local
 (g01jpexchkw02.g01.fujitsu.local [10.0.194.41])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 923021DB8038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 09:44:14 +0900 (JST)
Message-ID: <50B55E28.1030608@jp.fujitsu.com>
Date: Wed, 28 Nov 2012 09:43:20 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Patch v4 00/12] memory-hotplug: hot-remove physical memory
References: <1354010422-19648-1-git-send-email-wency@cn.fujitsu.com>
 <20121127112741.b616c2f6.akpm@linux-foundation.org>
In-Reply-To: <20121127112741.b616c2f6.akpm@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 Wen Congyang <wency@cn.fujitsu.com>, linux-acpi@vger.kernel.org,
 linux-sh@vger.kernel.org, Len Brown <len.brown@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
 Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org, paulus@samba.org,
 Minchan Kim <minchan.kim@gmail.com>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 David Rientjes <rientjes@google.com>, sparclinux@vger.kernel.org,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Jiang Liu <liuj97@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

2012/11/28 4:27, Andrew Morton wrote:
> On Tue, 27 Nov 2012 18:00:10 +0800
> Wen Congyang <wency@cn.fujitsu.com> wrote:
>
>> The patch-set was divided from following thread's patch-set.
>>      https://lkml.org/lkml/2012/9/5/201
>>
>> The last version of this patchset:
>>      https://lkml.org/lkml/2012/11/1/93
>
> As we're now at -rc7 I'd prefer to take a look at all of this after the
> 3.7 release - please resend everything shortly after 3.8-rc1.

Almost patches about memory hotplug has been merged into your and Rafael's
tree. And these patches are waiting to open the v3.8 merge window.
Remaining patches are only this patch-set. So we hope that this patch-set
is merged into v3.8.

In merging this patch-set into v3.8, Linux on x86_64 makes a memory hot plug
possible.

Thanks,
Yasuaki Ishimatsu

>
>> If you want to know the reason, please read following thread.
>>
>> https://lkml.org/lkml/2012/10/2/83
>
> Please include the rationale within each version of the patchset rather
> than by linking to an old email.  Because
>
> a) this way, more people are likely to read it
>
> b) it permits the text to be maimtained as the code evolves
>
> c) it permits the text to be included in the mainlnie commit, where
>     people can find it.
>
>> The patch-set has only the function of kernel core side for physical
>> memory hot remove. So if you use the patch, please apply following
>> patches.
>>
>> - bug fix for memory hot remove
>>    https://lkml.org/lkml/2012/10/31/269
>>
>> - acpi framework
>>    https://lkml.org/lkml/2012/10/26/175
>
> What's happening with the acpi framework?  has it received any feedback
> from the ACPI developers?
>
