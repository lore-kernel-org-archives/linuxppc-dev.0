Return-Path: <pku.leo@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
 [209.85.215.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 0120BB6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jan 2012 16:17:44 +1100 (EST)
Received: by eaal12 with SMTP id l12so1883879eaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Jan 2012 21:17:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F099291.6060803@yandex.ru>
References: <4F088122.4080505@yandex.ru>
 <CAL411-riz_Cf1hYMYwEKrJKNHTV3EYup4u5DjmBhdpH+4xcd7g@mail.gmail.com>
 <4F099291.6060803@yandex.ru>
Date: Mon, 9 Jan 2012 13:17:38 +0800
Message-ID: <CADRPPNRLKhDEU=mVDjbxaNtOD+665hQodhQzpVBc11120GpuJQ@mail.gmail.com>
Subject: Re: Driver(s) for Synopsys' DesignWare USB OTG
From: Leo Li <pku.leo@gmail.com>
To: Nikolai Zhubr <n-a-zhubr@yandex.ru>
Content-Type: text/plain; charset=UTF-8
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

On Sun, Jan 8, 2012 at 8:56 PM, Nikolai Zhubr <n-a-zhubr@yandex.ru> wrote:
> Hello Piter,
>
>
> 08.01.2012 7:12, you wrote:
>>
>> 2012/1/8 Nikolai Zhubr<n-a-zhubr@yandex.ru>:
>>>
>>> Hello developers,
>>>
>>> I'm trying to find/combine/fix a driver for Synopsys' DesignWare USB
>>> controller. This thing is USB 2.0 host/slave/otg capable and is used in
>>> various SoCs including Amlogic 8726M, Ralink RT305x, and probably more.
>>>
> [...trim...]
>>
>>
>> Please see:
>> http://marc.info/?l=linux-usb&m=129906859817430&w=2
>
> Ah, thanks. So sadly uncoordinated work in this area is quite common.
> However, in case of Synopsys the situation is even more disappointing
> because initially it _was_ a single driver! What probably lacked was some
> shared repository and proper communication between developers to stay in
> sync. Maybe there were also licensing issues at some point, though currently
> file headers contain rather reasonable (imho) permissive license from
> Synopsys.

I think the challenge of cooperation in situation like this is that
most companies don't like to advertise the source of the licensed IP
block.  Even the owner of the IP block doesn't list all users of the
block(maybe business requirement). It was really hard to find out if
the same IP has been used by anyone else.  Also the owner of this USB
IP block has been changed for several times(ARC, TDI, ChipIdea, and
Synopsys) which made it even more difficult to tell.

>
>
>> I am not sure we can combine all Synopsys USB drivers to single file, but
>> we
>
>
> Synopsys driver which I examine consists of 16 files (each of 2 versions),
> 200k lines total. I've already perpared some few smaller files for version
> merging. So probably it is doable, but quite a lot of work, therefore I
> wouldn't like it to be wasted.

I didn't examine the Synopsys driver myself.  But if it is so complex
as you described, it might be better to start with the in-tree drivers
IMO.

- Leo
