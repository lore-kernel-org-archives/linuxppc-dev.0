Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytW7V4QgBzDrnr
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 22:57:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci\@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Darren Stevens <darren@stevens-zone.net>, Bjorn Helgaas <helgaas@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] SB600 for the Nemo board has non-zero devices on non-root
 bus
In-Reply-To: <CAOesGMj2FL2NmbyM+LLYYYxesFQw=5Fo9HvZO4FcJhGh1GHJ+g@mail.gmail.com>
References: <87tvxl15qx.fsf@concordia.ellerman.id.au>
 <4cfe3cc0-7fe3-9774-7d20-1b7fcb7aa910@xenosoft.de>
 <CAErSpo55Q8Q=5p6_+uu7ahnw+53ibVDNRXxrzRV9QnUr_9EUfw@mail.gmail.com>
 <28b43e1a-3643-9edb-7123-be1cb0dc846a@xenosoft.de>
 <CAErSpo7fup7+doD6A7RKh8kdE8HQaQrEh=gq35+nC-dBeOQ1uA@mail.gmail.com>
 <527175f7-8a13-37a1-9f0a-0b918aeebd64@xenosoft.de>
 <20171130224243.GB19640@bhelgaas-glaptop.roam.corp.google.com>
 <406ba7c4-7305-4069-227f-81afed202e47@xenosoft.de>
 <20171201232716.GA18780@bhelgaas-glaptop.roam.corp.google.com>
 <6d2505ab-a985-bdb0-ad3a-e7659cc2c54d@xenosoft.de>
 <20171202230052.34y2ivxgpgr3osct@localhost>
 <87indkdo03.fsf@concordia.ellerman.id.au>
 <CAOesGMj2FL2NmbyM+LLYYYxesFQw=5Fo9HvZO4FcJhGh1GHJ+g@mail.gmail.com>
Date: Fri, 08 Dec 2017 22:57:42 +1100
Message-ID: <87a7yth1op.fsf@concordia.ellerman.id.au>
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
> On Wed, Dec 6, 2017 at 4:44 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Olof Johansson <olof@lixom.net> writes:
>>>
>>> The below patch, together with Bjorn's, should do it. Christian, can you test
>>> and report back?
>>>
>>> I'm guessing it won't do any harm to set this on non-X1000 platforms. My
>>> test system is currently powered down so I can't check.
>>
>> My pasemi board had been powered off for a while and when I turned it
>> back on something popped, the power supply blew up and tripped a
>> breaker.
>>
>> So I also can't test this, at least for now, until I get my "allowed to
>> use hardware" license back from my colleagues in the office.
>
> Ouch. Sounds like it's the PSU not the board. Hopefully there was no
> board damage, let me know if you need a replacement though and I'll
> see what I can find.

Thanks. Yeah the power supply is toast. One of the guys is going to see
if he can fix it.

Will try and get the board going, will let you know if it's dead too.

cheers
