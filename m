Return-Path: <olof@lixom.net>
Received: from mail-lf0-x22f.google.com (mail-lf0-x22f.google.com
 [IPv6:2a00:1450:4010:c07::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysNT829tCzDrRp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 02:54:03 +1100 (AEDT)
Received: by mail-lf0-x22f.google.com with SMTP id i2so4751415lfe.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Dec 2017 07:54:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87indkdo03.fsf@concordia.ellerman.id.au>
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
From: Olof Johansson <olof@lixom.net>
Date: Wed, 6 Dec 2017 07:53:58 -0800
Message-ID: <CAOesGMj2FL2NmbyM+LLYYYxesFQw=5Fo9HvZO4FcJhGh1GHJ+g@mail.gmail.com>
Subject: Re: [PATCH] SB600 for the Nemo board has non-zero devices on non-root
 bus
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Darren Stevens <darren@stevens-zone.net>,
 Bjorn Helgaas <helgaas@kernel.org>,
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

On Wed, Dec 6, 2017 at 4:44 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Olof Johansson <olof@lixom.net> writes:
>
>> On Sat, Dec 02, 2017 at 01:54:41PM +0100, Christian Zigotzky wrote:
>>> On 02 December 2017 at 00:27AM, Bjorn Helgaas wrote:
>>> >
>>> > Thanks for testing that.  I'll merge a similar patch for v4.16.
>>> >
>>> > I don't think using "pci=pcie_scan_all" is really an acceptable
>>> > long-term answer for you, though.  Is there some way we can identify
>>> > at run-time whether we're on a Nemo system?  If so, we can make this
>>> > happen automatically.
>>> >
>>> > Bjorn
>>> >
>>> Hi Bjorn,
>>>
>>> Many thanks for your effort! I appreciate it very much. :-)
>>>
>>> We can identify the Nemo board at the boot time. See dmesg output: [
>>> 0.061592] NEMO SB600 IOB base e0000000
>>>
>>> @linuxppc-dev
>>> Any other ideas? Maybe the same as we can identify the other P.A. Semi
>>> boards (Electra, Chitra, and Athena).
>>>
>>> @Olof
>>> Maybe you know how we can identify the P.A. Semi Nemo board at the run-time.
>>>
>>> @Darren
>>> Do you have an idea?
>>
>>
>> The below patch, together with Bjorn's, should do it. Christian, can you test
>> and report back?
>>
>> I'm guessing it won't do any harm to set this on non-X1000 platforms. My
>> test system is currently powered down so I can't check.
>
> My pasemi board had been powered off for a while and when I turned it
> back on something popped, the power supply blew up and tripped a
> breaker.
>
> So I also can't test this, at least for now, until I get my "allowed to
> use hardware" license back from my colleagues in the office.

Ouch. Sounds like it's the PSU not the board. Hopefully there was no
board damage, let me know if you need a replacement though and I'll
see what I can find.


-Olof
