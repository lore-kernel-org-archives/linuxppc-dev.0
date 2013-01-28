Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id AA09B2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2013 13:00:05 +1100 (EST)
Message-ID: <5105D57D.3050900@cn.fujitsu.com>
Date: Mon, 28 Jan 2013 09:33:49 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH Bug fix 0/5] Bug fix for physical memory hot-remove.
References: <1358854984-6073-1-git-send-email-tangchen@cn.fujitsu.com>
 <1358944171.3351.1.camel@kernel> <20130125131740.GA1615@dhcp22.suse.cz>
In-Reply-To: <20130125131740.GA1615@dhcp22.suse.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: len.brown@intel.com, linux-mm@kvack.org, paulus@samba.org, hpa@zytor.com,
 cl@linux.com, sfr@canb.auug.org.au, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 Simon Jeons <simon.jeons@gmail.com>, jiang.liu@huawei.com,
 wency@cn.fujitsu.com, julian.calaby@gmail.com, glommer@parallels.com,
 wujianguo@huawei.com, yinghai@kernel.org, laijs@cn.fujitsu.com,
 linux-kernel@vger.kernel.org, minchan.kim@gmail.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/25/2013 09:17 PM, Michal Hocko wrote:
> On Wed 23-01-13 06:29:31, Simon Jeons wrote:
>> On Tue, 2013-01-22 at 19:42 +0800, Tang Chen wrote:
>>> Here are some bug fix patches for physical memory hot-remove. All these
>>> patches are based on the latest -mm tree.
>>> git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git akpm
>>>
>>> And patch1 and patch3 are very important.
>>> patch1: free compound pages when freeing memmap, otherwise the kernel
>>>          will panic the next time memory is hot-added.
>>> patch3: the old way of freeing pagetable pages was wrong. We should never
>>>          split larger pages into small ones.
>>>
>>>
>>
>> Hi Tang,
>>
>> I remember your big physical memory hot-remove patchset has already
>> merged by Andrew, but where I can find it? Could you give me git tree
>> address?
>
> Andrew tree is also mirrored into a git tree.
> http://git.kernel.org/?p=linux/kernel/git/mhocko/mm.git;a=summary
>
> It contains only Memory management patches on top of the last major
> release (since-.X.Y branch).

Hi Michal,

I'm not sure I got your meaning. :)

In http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git akpm,
I can find the following commit.

commit deed0460e01b3968f2cf46fb94851936535b7e0d
Author: Tang Chen <tangchen@cn.fujitsu.com>
Date:   Sat Jan 19 11:07:13 2013 +1100

     memory-hotplug: do not allocate pgdat if it was not freed when 
offline.


This is one of memory hot-remove patches. Please try to update the 
mirror tree,
and try to find the above commit.

Thanks. :)
