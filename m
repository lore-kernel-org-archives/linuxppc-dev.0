Return-Path: <johnny.hacking@gmail.com>
Received: from mail-yx0-f195.google.com (mail-yx0-f195.google.com
	[209.85.210.195])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 18EFBB70B5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 17:33:14 +1000 (EST)
Received: by yxe33 with SMTP id 33so7824869yxe.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 00:33:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2ea1731b0906292329t30cdc9a6q1fc36dc2273a2931@mail.gmail.com>
References: <cb9ecdfa0906290858x125b8149na037f33258c21426@mail.gmail.com>
	<20090629165133.GC1323@b07421-ec1.am.freescale.net>
	<cb9ecdfa0906291836mf74c41fn9c187e305771920a@mail.gmail.com>
	<2ea1731b0906292329t30cdc9a6q1fc36dc2273a2931@mail.gmail.com>
Date: Tue, 30 Jun 2009 15:33:11 +0800
Message-ID: <cb9ecdfa0906300033x4dfcc315gfd67522b77f6004a@mail.gmail.com>
Subject: Re: PCI device support in Open Firmware (device tree syntax)
From: Johnny Hung <johnny.hacking@gmail.com>
To: Marco Stornelli <marco.stornelli@gmail.com>, linux-embedded@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/6/30 Marco Stornelli <marco.stornelli@gmail.com>:
> 2009/6/30 Johnny Hung <johnny.hacking@gmail.com>:
>> Thanks for your reply. So there are no PCI device resource info in
>> flat device tree.
>> How do PCI device resources be assign in general case or is there any example?
>> I am so confusing, would you please give me detailed describle?
>>
>> BRs, H. Johnny
>>>
>
> You should look at your bootloader about the initial configuration of
> the pci device, in general it should (more or less) do the work of
> BIOS as you said. After that the kernel can probe them.
>
> Marco
>
You are right. u-boot do PCI device BAR resources assign and flat
device tree describe PCI device interrupt-map. I use "lspci -s xxx -x"
for the PCI device, the resources was assigned properly.
Thanks.

BRs, H. Johnny
