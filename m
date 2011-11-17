Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 59B02B71E9
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2011 03:55:53 +1100 (EST)
Subject: Re: [PATCH][v2] powerpc/85xx: Rework P1022DS device tree
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=iso-8859-1
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CAOZdJXW9Ygz9nMmXgV_GaTPEQHi0zHB7d7uBAPV4fN7-p+ST-Q@mail.gmail.com>
Date: Thu, 17 Nov 2011 10:55:46 -0600
Message-Id: <18E17E7E-7108-4009-BB30-5EDC10C205B0@kernel.crashing.org>
References: <1321540377-3672-1-git-send-email-galak@kernel.crashing.org>
 <CAOZdJXW9Ygz9nMmXgV_GaTPEQHi0zHB7d7uBAPV4fN7-p+ST-Q@mail.gmail.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 17, 2011, at 10:04 AM, Tabi Timur-B04825 wrote:

> On Thu, Nov 17, 2011 at 8:32 AM, Kumar Gala =
<galak@kernel.crashing.org> wrote:
>> Utilize new split between board & SoC, and new SoC device trees split
>> into pre & post utilizing 'template' includes for SoC IP blocks.
>>=20
>> Other changes include:
>>=20
>> * Reworked PCIe nodes to allow supportin IRQs for controller (errors)
>>  and moved PCI device IRQs down to virtual bridge level
>> * Changed GPIO compatiable from 'fsl,mpc8572-gpio' to 'fsl,pq3-gpio' =
as the
>>  'mpc8572' compatiable is to deal with a 'mpc8572' specific to an =
erratum
>> * Updated spi node to new espi binding specification
>> * Renamed SDHC node from 'sdhci' to 'sdhc'
>> * Added usb node for 2nd usb controller
>> * Dropping "fsl,p1022-IP..." from compatibles for standard blocks
>> * Fixed bug in local bus range node for CS2, was maping to
>>  0x0 0x0xffa00000 instead of 0xf 0xffa00000
>> * Fixed localbus reg property should have been 0xf 0xffe05000
>>=20
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>> v2: fixed localbus reg property
>=20
> Acked-by: Timur Tabi <timur@freescale.com>

How about a Tested-by:

:)

- k
