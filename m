Return-Path: <bgholikh@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id 27F6867F7B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 06:48:25 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 8 Aug 2005 13:48:18 -0700
Message-ID: <F795765B112E7344AF36AA91127964158494EF@xmb-sjc-212.amer.cisco.com>
From: "Bizhan Gholikhamseh \(bgholikh\)" <bgholikh@cisco.com>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: pci_enable_device fails on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar,
I am using Linux 2.6.11 version. Currently I do not have
the "lspci" patch integrated into my Linux image, however the /proc/pci
exists. The Freescale FAE is telling me to turn ON bit 3 on SW1 (i.e.
making Tsi320 to transparent bridge) on the mother board (i.e. arcadia
board). After doing that, the system hangs during boot right after the
decompressing the Linux image.
=20
Regards,
Bizhan

-----Original Message-----
From: Kumar Gala [mailto:kumar.gala@freescale.com]=20
Sent: Monday, August 08, 2005 1:34 PM
To: Bizhan Gholikhamseh (bgholikh)
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: pci_enable_device fails on MPC8541

Bizhan,

A few questions:

1. what kernel version are you using on these boards:
2. can you do an lspci -v on the boards

- kumar

On Aug 8, 2005, at 1:12 PM, Bizhan Gholikhamseh \(((bgholikh\))) wrote:

> Hi All,
> I am using two evaluation board from freescale, 8540ADS and MPC8541.=20
> The same PCI driver is being compiled and loaded on both platforms.=20
> The same PCI driver (developed by me) for DSP board compiled and=20
> loaded on both platforms.
>
> When I type: "insmod C6415.ko" on 8541 board, I get the following
> error:
> "PCI: Device 0000:02:01.0 not available because of resource=20
> collisions"
> This messages is because of the execution of the generic PCI Linux
> command:
> "pci_enable_device(pdev)"
> The same API has no problem on 8540ADS.
>
>
>> From UBOOT I can see my device is on bus 3:
>>
> =3D> pci 3
> Scanning PCI devices on bus 3
> BusDev FUN    VendorID    DeviceID    Device Class    Sub-Class
> ----------------------------------------------------------------------
> --
> --------------------
> 03.01.00            0x104c    0xa106        .........
>
> Any idea why the insmod fails on one board and not on the other one?
>
> Many thanks in advance,
> Bizhan
>
> <ATT2118305.txt>
>
