Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 00FB867F7F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Aug 2005 06:34:07 +1000 (EST)
In-Reply-To: <F795765B112E7344AF36AA91127964158494EB@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA91127964158494EB@xmb-sjc-212.amer.cisco.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F0135BBF-EAF0-441C-84AF-257A0FCCC37D@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 8 Aug 2005 15:34:06 -0500
To: "Bizhan Gholikhamseh \\((bgholikh\\))" <bgholikh@cisco.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: pci_enable_device fails on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bizhan,

A few questions:

1. what kernel version are you using on these boards:
2. can you do an lspci -v on the boards

- kumar

On Aug 8, 2005, at 1:12 PM, Bizhan Gholikhamseh \(((bgholikh\))) wrote:

> Hi All,
> I am using two evaluation board from freescale, 8540ADS and  
> MPC8541. The
> same PCI driver is being compiled and loaded on both platforms. The  
> same
> PCI driver (developed by me) for DSP board compiled and loaded on both
> platforms.
>
> When I type: "insmod C6415.ko" on 8541 board, I get the following  
> error:
> "PCI: Device 0000:02:01.0 not available because of resource  
> collisions"
> This messages is because of the execution of the generic PCI Linux
> command:
> "pci_enable_device(pdev)"
> The same API has no problem on 8540ADS.
>
>
>> From UBOOT I can see my device is on bus 3:
>>
> => pci 3
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
