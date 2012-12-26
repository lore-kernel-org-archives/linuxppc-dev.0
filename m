Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2B2432C007A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 14:38:07 +1100 (EST)
Received: from m2.gw.fujitsu.co.jp (unknown [10.0.50.72])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 3CC6A3EE0C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:38:06 +0900 (JST)
Received: from smail (m2 [127.0.0.1])
 by outgoing.m2.gw.fujitsu.co.jp (Postfix) with ESMTP id 21F5045DE81
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:38:06 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (s2.gw.fujitsu.co.jp [10.0.50.92])
 by m2.gw.fujitsu.co.jp (Postfix) with ESMTP id DE31245DD74
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:38:05 +0900 (JST)
Received: from s2.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id D13421DB803F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:38:05 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s2.gw.fujitsu.co.jp (Postfix) with ESMTP id 89B181DB8038
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2012 12:38:05 +0900 (JST)
Message-ID: <50DA70E0.3050704@jp.fujitsu.com>
Date: Wed, 26 Dec 2012 12:37:04 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: Tang Chen <tangchen@cn.fujitsu.com>
Subject: Re: [PATCH v5 05/14] memory-hotplug: introduce new function
 arch_remove_memory() for removing page table depends on architecture
References: <1356350964-13437-1-git-send-email-tangchen@cn.fujitsu.com>
 <1356350964-13437-6-git-send-email-tangchen@cn.fujitsu.com>
In-Reply-To: <1356350964-13437-6-git-send-email-tangchen@cn.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, liuj97@gmail.com,
 len.brown@intel.com, wency@cn.fujitsu.com, cmetcalf@tilera.com,
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

(2012/12/24 21:09), Tang Chen wrote:
> From: Wen Congyang <wency@cn.fujitsu.com>
> 
> For removing memory, we need to remove page table. But it depends
> on architecture. So the patch introduce arch_remove_memory() for
> removing page table. Now it only calls __remove_pages().
> 
> Note: __remove_pages() for some archtecuture is not implemented
>        (I don't know how to implement it for s390).
> 
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>

Then, remove code will be symetric to add codes.

Acked-by: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
