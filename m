Return-Path: <tim.gardner@canonical.com>
Received: from mail.tpi.com (mail.tpi.com [74.45.170.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE31D1A0186
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 22:41:34 +1000 (AEST)
Message-ID: <55B0DA42.2050704@canonical.com>
Date: Thu, 23 Jul 2015 06:12:50 -0600
From: Tim Gardner <tim.gardner@canonical.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [4.2-rc3] macintosh/ans-lcd.c: Missing include causes compile
 failure
References: <20150723101844.9D3F0140D19@ozlabs.org>
In-Reply-To: <20150723101844.9D3F0140D19@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2015 04:18 AM, Michael Ellerman wrote:
> On Mon, 2015-20-07 at 19:01:42 UTC, Tim Gardner wrote:
>> From: Tim Gardner <tim.gardner@canonical.com>
>>
>> drivers/macintosh/ans-lcd.c:201:1: warning: data definition has no type or storage class
>>   module_init(anslcd_init);
>>   ^
>> drivers/macintosh/ans-lcd.c:201:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
>>
>> gcc version 4.9.3 (Ubuntu 4.9.3-1ubuntu1)
>
> Thanks Tim but Luis beat you to it:
>
>    http://patchwork.ozlabs.org/patch/497138/
>
>
> I'll send the fix to Linus in the next day or two.
>
> cheers
>

No problem. It looks like a better fix then mine anyway.

rtg
-- 
Tim Gardner tim.gardner@canonical.com
