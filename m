Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B204B2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 18:45:22 +1000 (EST)
Received: from m3.gw.fujitsu.co.jp (unknown [10.0.50.73])
 by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 8785F3EE0C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 17:45:21 +0900 (JST)
Received: from smail (m3 [127.0.0.1])
 by outgoing.m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 7A2E545DEB5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 17:45:21 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (s3.gw.fujitsu.co.jp [10.0.50.93])
 by m3.gw.fujitsu.co.jp (Postfix) with ESMTP id 6584445DEB2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 17:45:21 +0900 (JST)
Received: from s3.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 551121DB8038
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 17:45:21 +0900 (JST)
Received: from g01jpfmpwyt01.exch.g01.fujitsu.local
 (g01jpfmpwyt01.exch.g01.fujitsu.local [10.128.193.38])
 by s3.gw.fujitsu.co.jp (Postfix) with ESMTP id 0BE931DB803B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 17:45:21 +0900 (JST)
Message-ID: <5215CF7F.5060109@jp.fujitsu.com>
Date: Thu, 22 Aug 2013 17:44:47 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Seth Jennings <sjenning@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/7] drivers: base: move mutex lock out of
 add_memory_section()
References: <1377018783-26756-1-git-send-email-sjenning@linux.vnet.ibm.com>
 <20130820172445.GE4151@medulla.variantweb.net>
In-Reply-To: <20130820172445.GE4151@medulla.variantweb.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Dave Hansen <dave@sr71.net>, Lai Jiangshan <laijs@cn.fujitsu.com>,
 linuxppc-dev@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Yinghai Lu <yinghai@kernel.org>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Cody P Schafer <cody@linux.vnet.ibm.com>,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

(2013/08/21 2:24), Seth Jennings wrote:
> Gah! Forgot the cover letter.
>
> This patchset just seeks to clean up and refactor some things in
> memory.c for better understanding and possibly better performance due do
> a decrease in mutex acquisitions and refcount churn at boot time.  No
> functional change is intended by this set!

All patches were
Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Tested-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks,
Yasuaki Ishimatsu

>
> Seth
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
>
