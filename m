Return-Path: <hramrach@gmail.com>
Received: from mail-lf0-x232.google.com (mail-lf0-x232.google.com
 [IPv6:2a00:1450:4010:c07::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFHPR2wF7zF0Pr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jan 2018 12:14:50 +1100 (AEDT)
Received: by mail-lf0-x232.google.com with SMTP id w23so312489lfd.11
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Jan 2018 17:14:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOesGMhGt6arTt9p9rxT8Qreaucae0i=fmQoqkBvUGJOxobhiQ@mail.gmail.com>
References: <36E75811-C758-49B1-8E5C-3A2C44FD5DE9@xenosoft.de>
 <874lnzz5y3.fsf@concordia.ellerman.id.au>
 <86eade29-a56d-2aab-050e-366f4d43ab2f@xenosoft.de>
 <CAOesGMhGt6arTt9p9rxT8Qreaucae0i=fmQoqkBvUGJOxobhiQ@mail.gmail.com>
From: Michal Suchanek <hramrach@gmail.com>
Date: Mon, 8 Jan 2018 02:14:06 +0100
Message-ID: <CAOMqctS0d9i5F1si3mDq_M1ZZM1MncXRBFKGeZ4y30J4H_1RDg@mail.gmail.com>
Subject: Re: Spectre+Meltdown
To: Olof Johansson <olof@lixom.net>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
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

On 7 January 2018 at 19:54, Olof Johansson <olof@lixom.net> wrote:
> On Sun, Jan 7, 2018 at 5:04 AM, Christian Zigotzky
> <chzigotzky@xenosoft.de> wrote:
>> Hello Michael,
>>
>> Thanks for your reply. We are using P.A. Semi and Freescale CPUs.
>>
>> @Olof
>> Do you have some infos for us?
>
> I'm low on spare time to experiment and explore what might be exposed
> or not, and I no longer have any proprietary microarchitecture
> documentation of the core.
>
> I suggest reaching out to your supplier of the silicon for commercial
> support and information, or just going with what I'm sure will be
> architecturally generic solutions to the problem when IBM has them
> ready.

The solution for IBM POWER involves patching the firmware as well as
Linux. Without knowledge of the architecture specifics it is not
possible to tell if other cores are affected and if the measures
implemented by IBM can be used. In fact they probably rely on
64s-specific instructions and are in part implemented in 64s-specific
assembly files.

So this will not work without support for the specific core either by
the vendor or somebody who has knowledge of the architecture details.

Thanks

Michal
