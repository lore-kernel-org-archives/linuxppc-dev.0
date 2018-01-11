Return-Path: <pku.leo@gmail.com>
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com
 [209.85.223.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zH5q14t0lzF0VX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jan 2018 11:09:49 +1100 (AEDT)
Received: by mail-io0-f177.google.com with SMTP id 25so1348426ioj.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 16:09:49 -0800 (PST)
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com.
 [209.85.223.169])
 by smtp.gmail.com with ESMTPSA id 103sm10723151ioj.74.2018.01.10.16.09.46
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jan 2018 16:09:46 -0800 (PST)
Received: by mail-io0-f169.google.com with SMTP id z130so1341785ioe.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 16:09:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <32e12e24-750d-eb98-0753-f5feca309082@xenosoft.de>
References: <36E75811-C758-49B1-8E5C-3A2C44FD5DE9@xenosoft.de>
 <874lnzz5y3.fsf@concordia.ellerman.id.au>
 <86eade29-a56d-2aab-050e-366f4d43ab2f@xenosoft.de>
 <CAOesGMhGt6arTt9p9rxT8Qreaucae0i=fmQoqkBvUGJOxobhiQ@mail.gmail.com>
 <CAOMqctS0d9i5F1si3mDq_M1ZZM1MncXRBFKGeZ4y30J4H_1RDg@mail.gmail.com>
 <32e12e24-750d-eb98-0753-f5feca309082@xenosoft.de>
From: Li Yang <leoyang.li@nxp.com>
Date: Wed, 10 Jan 2018 18:09:45 -0600
Message-ID: <CADRPPNRtexannDrv8WtD2f3sQr9nwkN2PPgvh6m2r4d6BvqitQ@mail.gmail.com>
Subject: Re: Spectre+Meltdown
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Michal Suchanek <hramrach@gmail.com>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 8, 2018 at 2:17 AM, Christian Zigotzky
<chzigotzky@xenosoft.de> wrote:
> Hi All,
>
> Thanks a lot for your replies.
>
> @NXP developers: Could you please tell us some information?

We have done some investigation but it is not ready to be published
yet.  You can get more information from your support channel right
now.

>
> Thanks,
> Christian
>
>
>
> On 08 January 2018 at 02:14AM, Michal Suchanek wrote:
>>
>> On 7 January 2018 at 19:54, Olof Johansson <olof@lixom.net> wrote:
>>>
>>> On Sun, Jan 7, 2018 at 5:04 AM, Christian Zigotzky
>>> <chzigotzky@xenosoft.de> wrote:
>>>>
>>>> Hello Michael,
>>>>
>>>> Thanks for your reply. We are using P.A. Semi and Freescale CPUs.
>>>>
>>>> @Olof
>>>> Do you have some infos for us?
>>>
>>> I'm low on spare time to experiment and explore what might be exposed
>>> or not, and I no longer have any proprietary microarchitecture
>>> documentation of the core.
>>>
>>> I suggest reaching out to your supplier of the silicon for commercial
>>> support and information, or just going with what I'm sure will be
>>> architecturally generic solutions to the problem when IBM has them
>>> ready.
>>
>> The solution for IBM POWER involves patching the firmware as well as
>> Linux. Without knowledge of the architecture specifics it is not
>> possible to tell if other cores are affected and if the measures
>> implemented by IBM can be used. In fact they probably rely on
>> 64s-specific instructions and are in part implemented in 64s-specific
>> assembly files.
>>
>> So this will not work without support for the specific core either by
>> the vendor or somebody who has knowledge of the architecture details.
>>
>> Thanks
>>
>> Michal
>>
>
