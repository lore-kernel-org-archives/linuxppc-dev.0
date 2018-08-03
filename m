Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hjk76vtPzF2D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 20:21:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Darren Stevens <darren@stevens-zone.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/pasemi: Seach for PCI root bus by compatible
 property
In-Reply-To: <CAOesGMig7yYay8dZsjsc7pmZsqmHTrGDZOukOqOkTzjEB3=z1Q@mail.gmail.com>
References: <4c4cb2b4391.4d23d508@auth.smtp.1and1.co.uk>
 <8736vzhb6h.fsf@concordia.ellerman.id.au>
 <87zhy7fw7f.fsf@concordia.ellerman.id.au>
 <fde71219-5e0e-cc12-a31f-258ce547f471@xenosoft.de>
 <877elaf92a.fsf@concordia.ellerman.id.au>
 <CAOesGMig7yYay8dZsjsc7pmZsqmHTrGDZOukOqOkTzjEB3=z1Q@mail.gmail.com>
Date: Fri, 03 Aug 2018 20:20:59 +1000
Message-ID: <87k1p7hhtg.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Olof Johansson <olof@lixom.net> writes:
> On Wed, Aug 1, 2018 at 7:36 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Christian Zigotzky <chzigotzky@xenosoft.de> writes:
>>
>>> Just for info: I tested it on my Nemo board today and it works.
>>
>> Awesome thanks.
>>
>> That's probably sufficient to merge it, and if it breaks anything we can
>> always revert it.
>
> Should be fine, all known boards have the properties in question, and
> I doubt anyone has anything but Nemo and Electra/Chitra boards out
> there.
>
> It's a virtual root bus, so all boards have it irrespective of what
> PCIe is brought out.
>
> (I should hook up my test system and get it into the CI cycle again,
> maybe this fall).
>
>
> Acked-by: Olof Johansson <olof@lixom.net>

Thanks.

cheers
