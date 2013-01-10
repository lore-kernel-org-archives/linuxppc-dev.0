Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 83A3C2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 19:40:53 +1100 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 1F6C83EE0C3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 17:40:50 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 010FA45DEC1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 17:40:50 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id DDD2A45DEB7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 17:40:49 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id CD9ED1DB8042
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 17:40:49 +0900 (JST)
Received: from m1001.s.css.fujitsu.com (m1001.s.css.fujitsu.com
 [10.240.81.139])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 38FE61DB8043
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jan 2013 17:40:49 +0900 (JST)
Message-ID: <50EE7E5A.9090402@jp.fujitsu.com>
Date: Thu, 10 Jan 2013 17:39:54 +0900
From: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
To: Glauber Costa <glommer@parallels.com>
Subject: Re: [PATCH v6 00/15] memory-hotplug: hot-remove physical memory
References: <1357723959-5416-1-git-send-email-tangchen@cn.fujitsu.com>
 <20130109142314.1ce04a96.akpm@linux-foundation.org>
 <50EE24A4.8020601@cn.fujitsu.com> <50EE6A48.7060307@parallels.com>
 <50EE6E50.3040609@jp.fujitsu.com> <50EE73DE.30208@parallels.com>
 <50EE7A6B.7020005@jp.fujitsu.com> <50EE7D75.8080100@parallels.com>
In-Reply-To: <50EE7D75.8080100@parallels.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 Tang Chen <tangchen@cn.fujitsu.com>, linux-mm@kvack.org, paulus@samba.org,
 hpa@zytor.com, sparclinux@vger.kernel.org, cl@linux.com,
 linux-s390@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, linfeng@cn.fujitsu.com, mgorman@suse.de,
 kosaki.motohiro@jp.fujitsu.com, rientjes@google.com, len.brown@intel.com,
 wency@cn.fujitsu.com, cmetcalf@tilera.com, wujianguo@huawei.com,
 yinghai@kernel.org, laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org,
 minchan.kim@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(2013/01/10 17:36), Glauber Costa wrote:
  
>> BTW, shrink_slab() is now node/zone aware ? If not, fixing that first will
>> be better direction I guess.
>>
> It is not upstream, but there are patches for this that I am already
> using in my private tree.
>

Oh, I see. If it's merged, it's worth add "shrink_slab() if ZONE_NORMAL"
code.

Thanks,
-Kame
