Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 697562C0385
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Sep 2012 06:49:59 +1000 (EST)
Date: Fri, 31 Aug 2012 13:49:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: wency@cn.fujitsu.com
Subject: Re: [RFC v8 PATCH 00/20] memory-hotplug: hot-remove physical memory
Message-Id: <20120831134956.fec0f681.akpm@linux-foundation.org>
In-Reply-To: <1346148027-24468-1-git-send-email-wency@cn.fujitsu.com>
References: <1346148027-24468-1-git-send-email-wency@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-s390@vger.kernel.org, linux-ia64@vger.kernel.org, len.brown@intel.com,
 linux-acpi@vger.kernel.org, linux-sh@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, cmetcalf@tilera.com, linux-mm@kvack.org,
 isimatu.yasuaki@jp.fujitsu.com, paulus@samba.org, minchan.kim@gmail.com,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 sparclinux@vger.kernel.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Aug 2012 18:00:07 +0800
wency@cn.fujitsu.com wrote:

> This patch series aims to support physical memory hot-remove.

Have you had much review and testing feedback yet?

> The patches can free/remove the following things:
> 
>   - acpi_memory_info                          : [RFC PATCH 4/19]
>   - /sys/firmware/memmap/X/{end, start, type} : [RFC PATCH 8/19]
>   - iomem_resource                            : [RFC PATCH 9/19]
>   - mem_section and related sysfs files       : [RFC PATCH 10-11, 13-16/19]
>   - page table of removed memory              : [RFC PATCH 12/19]
>   - node and related sysfs files              : [RFC PATCH 18-19/19]
> 
> If you find lack of function for physical memory hot-remove, please let me
> know.

I doubt if many people have hardware which permits physical memory
removal?  How would you suggest that people with regular hardware can
test these chagnes?

> Known problems:
> 1. memory can't be offlined when CONFIG_MEMCG is selected.

That's quite a problem!  Do you have a description of why this is the
case, and a plan for fixing it?
