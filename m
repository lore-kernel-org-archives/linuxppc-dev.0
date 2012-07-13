Return-Path: <isimatu.yasuaki@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 900762C0309
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 14:34:48 +1000 (EST)
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
 by fgwmail5.fujitsu.co.jp (Postfix) with ESMTP id 9E0293EE0C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 13:34:45 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
 by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 830BA45DE53
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 13:34:45 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
 by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id 69AA845DE51
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 13:34:45 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 58FD91DB803B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 13:34:45 +0900 (JST)
Received: from g01jpexchyt08.g01.fujitsu.local
 (g01jpexchyt08.g01.fujitsu.local [10.128.194.47])
 by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 051EB1DB803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2012 13:34:45 +0900 (JST)
Message-ID: <4FFFA53C.8090707@jp.fujitsu.com>
Date: Fri, 13 Jul 2012 13:34:04 +0900
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

Thank you for reviewing my patch.
I'll send the patch.

Thanks,
Yasuaki Ishimatsu

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
