Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 596392C0339
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 15:12:25 +1000 (EST)
Received: from m1.gw.fujitsu.co.jp (unknown [10.0.50.71])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 8213F3EE0C7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 14:12:20 +0900 (JST)
Received: from smail (m1 [127.0.0.1])
 by outgoing.m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 5D01945DE60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 14:12:20 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (s1.gw.fujitsu.co.jp [10.0.50.91])
 by m1.gw.fujitsu.co.jp (Postfix) with ESMTP id 423BC45DE5A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 14:12:20 +0900 (JST)
Received: from s1.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id 34D51E78008
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 14:12:20 +0900 (JST)
Received: from g01jpexchkw10.g01.fujitsu.local
 (g01jpexchkw10.g01.fujitsu.local [10.0.194.49])
 by s1.gw.fujitsu.co.jp (Postfix) with ESMTP id DDC7AE78005
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 14:12:19 +0900 (JST)
Message-ID: <4FFFAE17.7070400@jp.fujitsu.com>
Date: Fri, 13 Jul 2012 14:11:51 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 3/13] memory-hotplug : unify argument of
 firmware_map_add_early/hotplug
References: <4FFAB0A2.8070304@jp.fujitsu.com>
 <4FFAB17F.2090209@jp.fujitsu.com> <4FFD9C08.2070502@linux.vnet.ibm.com>
 <4FFE5816.6070102@jp.fujitsu.com> <4FFED3CE.7030108@linux.vnet.ibm.com>
In-Reply-To: <4FFED3CE.7030108@linux.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Cc: len.brown@intel.com, wency@cn.fujitsu.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, paulus@samba.org,
 minchan.kim@gmail.com, kosaki.motohiro@jp.fujitsu.com, rientjes@google.com,
 cl@linux.com, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 liuj97@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Dave,

2012/07/12 22:40, Dave Hansen wrote:
> On 07/11/2012 09:52 PM, Yasuaki Ishimatsu wrote:
>> Does the following patch include your comment? If O.K., I will separate
>> the patch from the series and send it for bug fix.
> 
> Looks sane to me.  It does now mean that the calling conventions for
> some of the other firmware_map*() functions are different, but I think
> that's OK since they're only used internally to memmap.c.

Can I add "Reviewed-by: Dave Hansen" to the patch?

Thanks,
Yasuaki Ishimatsu

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
