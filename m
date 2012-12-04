Return-Path: <tangchen@cn.fujitsu.com>
Received: from song.cn.fujitsu.com (unknown [222.73.24.84])
 by ozlabs.org (Postfix) with ESMTP id F07A42C008D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2012 20:48:00 +1100 (EST)
Message-ID: <50BDC694.1060509@cn.fujitsu.com>
Date: Tue, 04 Dec 2012 17:47:00 +0800
From: Tang Chen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
To: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [Patch v4 08/12] memory-hotplug: remove memmap of sparse-vmemmap
References: <1354010422-19648-1-git-send-email-wency@cn.fujitsu.com>
 <1354010422-19648-9-git-send-email-wency@cn.fujitsu.com>
In-Reply-To: <1354010422-19648-9-git-send-email-wency@cn.fujitsu.com>
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

On 11/27/2012 06:00 PM, Wen Congyang wrote:
>   static int __remove_section(struct zone *zone, struct mem_section *ms)
>   {
>   	unsigned long flags;
> @@ -330,9 +317,9 @@ static int __remove_section(struct zone *zone, struct mem_section *ms)
>   	pgdat_resize_lock(pgdat,&flags);
>   	sparse_remove_one_section(zone, ms);
>   	pgdat_resize_unlock(pgdat,&flags);
> -	return 0;
> +
> +	return ret;

I think we don't need to change this line. :)

Reviewed-by: Tang Chen <tangchen@cn.fujitsu.com>
