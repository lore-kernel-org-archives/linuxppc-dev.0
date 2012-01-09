Return-Path: <n-a-zhubr@yandex.ru>
Received: from forward11.mail.yandex.net (forward11.mail.yandex.net
 [95.108.130.93]) by ozlabs.org (Postfix) with ESMTP id 96313B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 23:36:57 +1100 (EST)
Message-ID: <4F0AE08D.3040701@yandex.ru>
Date: Mon, 09 Jan 2012 16:41:49 +0400
From: Nikolai Zhubr <n-a-zhubr@yandex.ru>
MIME-Version: 1.0
To: Peter Chen <peter.chen@freescale.com>
Subject: Re: Driver(s) for Synopsys' DesignWare USB OTG
References: <4F088122.4080505@yandex.ru>
 <CAL411-riz_Cf1hYMYwEKrJKNHTV3EYup4u5DjmBhdpH+4xcd7g@mail.gmail.com>
 <4F099291.6060803@yandex.ru> <20120109021220.GA10198@nchen-desktop>
In-Reply-To: <20120109021220.GA10198@nchen-desktop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: support@amlogic.com, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, openwrt-devel@lists.openwrt.org,
 Peter Chen <hzpeterchen@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Peter,

09.01.2012 6:12, Peter Chen:
>>> I am not sure we can combine all Synopsys USB drivers to single file, but we
>>
>> Synopsys driver which I examine consists of 16 files (each of 2
>> versions), 200k lines total. I've already perpared some few smaller
>> files for version merging. So probably it is doable, but quite a lot
>> of work, therefore I wouldn't like it to be wasted.
> I mean one file is just a common udc driver for all Synopsys, not all usb file.
> For ehci, I think it will be easier to use single file as well as
> some specific SoC's quirks if needed.
> For udc, as there is no standard spec for how usb device should be designed,
> maybe different Synopsys IPs have a little different for work flow.
> For otg, it  should be not difficult after we split PHY's operation
> from the otg, as common otg operation is the same.
>>
>>> can try combine similar IP versions to one file, this work may need all Synopsys
>>> USB IP driver maintainer work together.
>>
>> Exactly. This is why I'm now trying to find all relevant people to
>> begin with.
> I know someone(@Pengutronix and @linux.intel.com) is doing that. I think first
> we should find which driver file at current code base is most capable and
> compatible. I would like to help it, and verify it at Freescale i.MX SoCs.

Ok. Because my resources are limited (and my knowledge is actually 
limited too) I'll list what exactly I'm able (and willing) to do:

- split formatting/naming/uninteresting changes from algorythmical 
changes, prepare clean diffs as necessary (boring work, but anyway);
- bisect changes which make the driver stop working on my tablet;
- try whichever driver parameters and see what happens to my tablet;
- connect the tablet to a regular linux PC with USB cable, do some 
tests, capture traffic dumps as necessary;
- connect some devices to the tablet, do tests, report results;

and with some luck:
- prepare bufixes (depending very much on how simple is the bug).

So basically my effort would probably only be usefull in cooperation 
with someone with more knowledge and understanding of the situation in 
whole. Otherwise it would be more wasting of time.

If usb issues were solved, it might make some sense to try to create 
e.g. a generic openwrt target for 8726m-based tablet. (Of course it 
wouldn't allow to use the device for its intended purpose yet, but still 
might be interesting as kind of devel/testing reference option)


Thank you.
Nikolai.


>>
>> Thank you.
>> Nikolai.
>>
>> Please CC me, I'm not subscribed to the lists.
>>
>>
>>>
>>>
>>>> Thank you.
>>>> Nikolai.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
