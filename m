Return-Path: <n-a-zhubr@yandex.ru>
Received: from forward14.mail.yandex.net (forward14.mail.yandex.net
 [IPv6:2a02:6b8:0:801::4])
 by ozlabs.org (Postfix) with ESMTP id EF2BEB6F68
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 23:39:02 +1100 (EST)
Message-ID: <4F0AE110.7010106@yandex.ru>
Date: Mon, 09 Jan 2012 16:44:00 +0400
From: Nikolai Zhubr <n-a-zhubr@yandex.ru>
MIME-Version: 1.0
To: Leo Li <pku.leo@gmail.com>
Subject: Re: Driver(s) for Synopsys' DesignWare USB OTG
References: <4F088122.4080505@yandex.ru>	<CAL411-riz_Cf1hYMYwEKrJKNHTV3EYup4u5DjmBhdpH+4xcd7g@mail.gmail.com>	<4F099291.6060803@yandex.ru>
 <CADRPPNRLKhDEU=mVDjbxaNtOD+665hQodhQzpVBc11120GpuJQ@mail.gmail.com>
In-Reply-To: <CADRPPNRLKhDEU=mVDjbxaNtOD+665hQodhQzpVBc11120GpuJQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hello Leo,

09.01.2012 9:17, Leo Li:
> On Sun, Jan 8, 2012 at 8:56 PM, Nikolai Zhubr<n-a-zhubr@yandex.ru>  wrote:
>>> 2012/1/8 Nikolai Zhubr<n-a-zhubr@yandex.ru>:
>>>>
>>>> Hello developers,
>>>>
>>>> I'm trying to find/combine/fix a driver for Synopsys' DesignWare USB
>>>> controller. This thing is USB 2.0 host/slave/otg capable and is used in
>>>> various SoCs including Amlogic 8726M, Ralink RT305x, and probably more.
>>>>
[...trim...]
>
> I think the challenge of cooperation in situation like this is that
> most companies don't like to advertise the source of the licensed IP
> block.  Even the owner of the IP block doesn't list all users of the
> block(maybe business requirement). It was really hard to find out if
> the same IP has been used by anyone else.  Also the owner of this USB
> IP block has been changed for several times(ARC, TDI, ChipIdea, and
> Synopsys) which made it even more difficult to tell.

Ah, I see. It explains.
But communicating in private and keeping some public repository up to 
date would still be allowed I suppose?

>
>>
>>
>>> I am not sure we can combine all Synopsys USB drivers to single file, but
>>> we
>>
>>
>> Synopsys driver which I examine consists of 16 files (each of 2 versions),
>> 200k lines total. I've already perpared some few smaller files for version
>> merging. So probably it is doable, but quite a lot of work, therefore I
>> wouldn't like it to be wasted.
>
> I didn't examine the Synopsys driver myself.  But if it is so complex
> as you described, it might be better to start with the in-tree drivers
> IMO.

Unfortunately its far beyond my capabilities at the moment. Besides, it 
looks like huge effort has already been invested into the existing 
driver, so to me it seems fixing it rather than starting from scratch 
would be more realistic anyway (unless a company with unlimited 
resources step in...)


Thank you.
Nikolai.

>
> - Leo
>
>
