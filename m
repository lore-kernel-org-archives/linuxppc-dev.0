Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFSmp5sGgzF0RS
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 19:17:12 +1100 (AEDT)
Subject: Spectre+Meltdown
To: Michal Suchanek <hramrach@gmail.com>, Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <36E75811-C758-49B1-8E5C-3A2C44FD5DE9@xenosoft.de>
 <874lnzz5y3.fsf@concordia.ellerman.id.au>
 <86eade29-a56d-2aab-050e-366f4d43ab2f@xenosoft.de>
 <CAOesGMhGt6arTt9p9rxT8Qreaucae0i=fmQoqkBvUGJOxobhiQ@mail.gmail.com>
 <CAOMqctS0d9i5F1si3mDq_M1ZZM1MncXRBFKGeZ4y30J4H_1RDg@mail.gmail.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Message-ID: <32e12e24-750d-eb98-0753-f5feca309082@xenosoft.de>
Date: Mon, 8 Jan 2018 09:17:05 +0100
MIME-Version: 1.0
In-Reply-To: <CAOMqctS0d9i5F1si3mDq_M1ZZM1MncXRBFKGeZ4y30J4H_1RDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi All,

Thanks a lot for your replies.

@NXP developers: Could you please tell us some information?

Thanks,
Christian


On 08 January 2018 at 02:14AM, Michal Suchanek wrote:
> On 7 January 2018 at 19:54, Olof Johansson <olof@lixom.net> wrote:
>> On Sun, Jan 7, 2018 at 5:04 AM, Christian Zigotzky
>> <chzigotzky@xenosoft.de> wrote:
>>> Hello Michael,
>>>
>>> Thanks for your reply. We are using P.A. Semi and Freescale CPUs.
>>>
>>> @Olof
>>> Do you have some infos for us?
>> I'm low on spare time to experiment and explore what might be exposed
>> or not, and I no longer have any proprietary microarchitecture
>> documentation of the core.
>>
>> I suggest reaching out to your supplier of the silicon for commercial
>> support and information, or just going with what I'm sure will be
>> architecturally generic solutions to the problem when IBM has them
>> ready.
> The solution for IBM POWER involves patching the firmware as well as
> Linux. Without knowledge of the architecture specifics it is not
> possible to tell if other cores are affected and if the measures
> implemented by IBM can be used. In fact they probably rely on
> 64s-specific instructions and are in part implemented in 64s-specific
> assembly files.
>
> So this will not work without support for the specific core either by
> the vendor or somebody who has knowledge of the architecture details.
>
> Thanks
>
> Michal
>
