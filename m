Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14B6EDDED7
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Apr 2009 23:26:45 +1000 (EST)
Message-Id: <F78629F9-59D2-4974-8461-06B7FAC2625D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
In-Reply-To: <20090428022711.GA30538@ime.usp.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: minimizing the configuration of
	linkstation_defconfig
Date: Tue, 28 Apr 2009 08:16:34 -0500
References: <20090424065816.GA15525@ime.usp.br>
	<Pine.LNX.4.64.0904242158210.8309@axis700.grange>
	<20090424223355.GB7858@ime.usp.br>
	<2CE2BC61-1C6B-4D01-870B-BC460730AD79@kernel.crashing.org>
	<20090428022711.GA30538@ime.usp.br>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 27, 2009, at 9:27 PM, Rog=E9rio Brito wrote:

> Hi, Kumar.
>
> On Apr 27 2009, Kumar Gala wrote:
>>
>> On Apr 24, 2009, at 5:33 PM, Rog=E9rio Brito wrote:
>>> 04. disable CONFIG_BLK_DEV_RAM.
>>
>> do we not allow booting a ramdisk?
>
> Well, do we need a block device in ram to use initramfs?
>
> (...)

I'm pretty sure we need this for old initrd style ramdisks so I'd =20
prefer we leave it enabled.

>>> Dear Kumar, please, apply this one.
>>>
>>> I have another patch regarding one regression regarding MTD &
>>> PHYSMAP_COMPAT that I plan to send on top of this one.
>>
>> Ok, can we look at just specifying such info in the linkstation =20
>> device
>> tree.
>
> Thanks. The MTD & PHYMAP_COMPAT are the things that have been =20
> bugging me
> and my main reason to keep with the bleeding edge kernels is to get =20=

> things
> whey they were (regarding mtd) as in kernel 2.6.28.
>
> As I have no experience with MTD devices, I would appreciate a =20
> reference to
> their workings... All that I know is that all my /dev/mtd* devices =20
> are gone
> if I boot a 2.6.29* kernel.
>
> Of course, I can do a git bisect process (since the MTD subsystem =20
> doesn't
> work as it did in the past even if I enable PHYMAP_COMPAT and put =20
> the same
> settings there, quite unfortunately).

ok.. I killed my kurobox long ago so can't be much help here.

- k=
