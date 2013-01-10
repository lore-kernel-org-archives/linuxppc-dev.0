Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id 9E8092C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 13:26:44 +1100 (EST)
Message-ID: <50EE26B4.40204@cn.fujitsu.com>
Date: Thu, 10 Jan 2013 10:25:56 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 05/15] memory-hotplug: introduce new function
 arch_remove_memory() for removing page table depends on architecture
References: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
 <1357723959-5416-6-git-send-email-tangchen@cn.fujitsu.com>
 <20130109145031.210505d0.akpm@linux-foundation.org>
In-Reply-To: <20130109145031.210505d0.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, len.brown@intel.com,
 wency@cn.fujitsu.com, cmetcalf@tilera.com, glommer@parallels.com,
 wujianguo@huawei.com, yinghai@kernel.org, laijs@cn.fujitsu.com,
 linux-kernel@vger.kernel.org, minchan.kim@gmail.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andrew,

On 01/10/2013 06:50 AM, Andrew Morton wrote:
> On Wed, 9 Jan 2013 17:32:29 +0800
> Tang Chen<tangchen@cn.fujitsu.com>  wrote:
>
>> For removing memory, we need to remove page table. But it depends
>> on architecture. So the patch introduce arch_remove_memory() for
>> removing page table. Now it only calls __remove_pages().
>>
>> Note: __remove_pages() for some archtecuture is not implemented
>>        (I don't know how to implement it for s390).
>
> Can this break the build for s390?

No, I don't think so. The arch_remove_memory() in s390 will only
return -EBUSY.

Thanks. :)

>
>
>
