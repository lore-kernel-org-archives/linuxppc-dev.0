Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 13D9F2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 21:32:18 +1100 (EST)
Message-ID: <50BDD0F4.8040806@cn.fujitsu.com>
Date: Tue, 04 Dec 2012 18:31:16 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [Patch v4 03/12] memory-hotplug: remove redundant codes
References: <1354010422-19648-1-git-send-email-wency@cn.fujitsu.com>
 <1354010422-19648-4-git-send-email-wency@cn.fujitsu.com>
 <50BDC0DE.4010103@cn.fujitsu.com>
In-Reply-To: <50BDC0DE.4010103@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org,
 Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org,
 linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 cmetcalf@tilera.com, Jianguo Wu <wujianguo@huawei.com>, linux-mm@kvack.org,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, paulus@samba.org,
 Minchan Kim <minchan.kim@gmail.com>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 David Rientjes <rientjes@google.com>, sparclinux@vger.kernel.org,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Andrew Morton <akpm@linux-foundation.org>, Jiang Liu <liuj97@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/04/2012 05:22 PM, Tang Chen wrote:
> On 11/27/2012 06:00 PM, Wen Congyang wrote:
>> offlining memory blocks and checking whether memory blocks are offlined
>> are very similar. This patch introduces a new function to remove
>> redundant codes.
>>
>> CC: David Rientjes<rientjes@google.com>
>> CC: Jiang Liu<liuj97@gmail.com>
>> CC: Len Brown<len.brown@intel.com>
>> CC: Christoph Lameter<cl@linux.com>
>> Cc: Minchan Kim<minchan.kim@gmail.com>
>> CC: Andrew Morton<akpm@linux-foundation.org>
>> CC: KOSAKI Motohiro<kosaki.motohiro@jp.fujitsu.com>
>> CC: Yasuaki Ishimatsu<isimatu.yasuaki@jp.fujitsu.com>
>> Signed-off-by: Wen Congyang<wency@cn.fujitsu.com>
>
> Can we merge this patch with [PATCH 03/12] ?

Sorry, I think we can merge this patch into [PATCH 02/12].
Thanks. :)

>
> Reviewed-by: Tang Chen <tangchen@cn.fujitsu.com>
>
