Return-Path: <n-a-zhubr@yandex.ru>
Received: from forward14.mail.yandex.net (forward14.mail.yandex.net
 [IPv6:2a02:6b8:0:801::4])
 by ozlabs.org (Postfix) with ESMTP id 94FF2B6F65
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Jan 2012 23:58:07 +1100 (EST)
Message-ID: <4F099291.6060803@yandex.ru>
Date: Sun, 08 Jan 2012 16:56:49 +0400
From: Nikolai Zhubr <n-a-zhubr@yandex.ru>
MIME-Version: 1.0
To: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: Driver(s) for Synopsys' DesignWare USB OTG
References: <4F088122.4080505@yandex.ru>
 <CAL411-riz_Cf1hYMYwEKrJKNHTV3EYup4u5DjmBhdpH+4xcd7g@mail.gmail.com>
In-Reply-To: <CAL411-riz_Cf1hYMYwEKrJKNHTV3EYup4u5DjmBhdpH+4xcd7g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: support@amlogic.com, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, openwrt-devel@lists.openwrt.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Piter,

08.01.2012 7:12, you wrote:
> 2012/1/8 Nikolai Zhubr<n-a-zhubr@yandex.ru>:
>> Hello developers,
>>
>> I'm trying to find/combine/fix a driver for Synopsys' DesignWare USB
>> controller. This thing is USB 2.0 host/slave/otg capable and is used in
>> various SoCs including Amlogic 8726M, Ralink RT305x, and probably more.
>>
[...trim...]
>
> Please see:
> http://marc.info/?l=linux-usb&m=129906859817430&w=2
Ah, thanks. So sadly uncoordinated work in this area is quite common. 
However, in case of Synopsys the situation is even more disappointing 
because initially it _was_ a single driver! What probably lacked was 
some shared repository and proper communication between developers to 
stay in sync. Maybe there were also licensing issues at some point, 
though currently file headers contain rather reasonable (imho) 
permissive license from Synopsys.

> I am not sure we can combine all Synopsys USB drivers to single file, but we

Synopsys driver which I examine consists of 16 files (each of 2 
versions), 200k lines total. I've already perpared some few smaller 
files for version merging. So probably it is doable, but quite a lot of 
work, therefore I wouldn't like it to be wasted.

> can try combine similar IP versions to one file, this work may need all Synopsys
> USB IP driver maintainer work together.

Exactly. This is why I'm now trying to find all relevant people to begin 
with.

Thank you.
Nikolai.

Please CC me, I'm not subscribed to the lists.


>
>
>> Thank you.
>> Nikolai.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
