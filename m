Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 5F3602C008C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2012 06:27:44 +1100 (EST)
Date: Tue, 27 Nov 2012 11:27:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [Patch v4 00/12] memory-hotplug: hot-remove physical memory
Message-Id: <20121127112741.b616c2f6.akpm@linux-foundation.org>
In-Reply-To: <1354010422-19648-1-git-send-email-wency@cn.fujitsu.com>
References: <1354010422-19648-1-git-send-email-wency@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 cmetcalf@tilera.com, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
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

On Tue, 27 Nov 2012 18:00:10 +0800
Wen Congyang <wency@cn.fujitsu.com> wrote:

> The patch-set was divided from following thread's patch-set.
>     https://lkml.org/lkml/2012/9/5/201
> 
> The last version of this patchset:
>     https://lkml.org/lkml/2012/11/1/93

As we're now at -rc7 I'd prefer to take a look at all of this after the
3.7 release - please resend everything shortly after 3.8-rc1.

> If you want to know the reason, please read following thread.
> 
> https://lkml.org/lkml/2012/10/2/83

Please include the rationale within each version of the patchset rather
than by linking to an old email.  Because

a) this way, more people are likely to read it

b) it permits the text to be maimtained as the code evolves

c) it permits the text to be included in the mainlnie commit, where
   people can find it.

> The patch-set has only the function of kernel core side for physical
> memory hot remove. So if you use the patch, please apply following
> patches.
> 
> - bug fix for memory hot remove
>   https://lkml.org/lkml/2012/10/31/269
>   
> - acpi framework
>   https://lkml.org/lkml/2012/10/26/175

What's happening with the acpi framework?  has it received any feedback
from the ACPI developers?
