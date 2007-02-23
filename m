Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 62D57DDF0D
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Feb 2007 07:19:08 +1100 (EST)
Date: Fri, 23 Feb 2007 14:29:21 -0600
To: "Morrison, Tom" <tmorrison@empirix.com>
Subject: Re: Update on: MPC85xx git/MPC8548cds - PCI/PCIE problemS with Marvel
	SATA driver...
Message-ID: <20070223202921.GA22331@lixom.net>
References: <BD261180E6D35F4D9D32F3E44FD3D9010685DAA6@EMPBEDEX.empirix.com>
	<BE415006-0D71-4D2F-8699-3BD2A513D9C0@freescale.com>
	<BD261180E6D35F4D9D32F3E44FD3D9010685DCFC@EMPBEDEX.empirix.com>
	<8B9F6546-0D85-4AD0-A196-25F0F9C1A5A0@freescale.com>
	<BD261180E6D35F4D9D32F3E44FD3D901069D9CA4@EMPBEDEX.empirix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D901069D9CA4@EMPBEDEX.empirix.com>
From: olof@lixom.net (Olof Johansson)
Cc: Geary Sean-R60898 <sean.geary@freescale.com>, linuxppc-dev@ozlabs.org,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Feb 23, 2007 at 02:57:38PM -0500, Morrison, Tom wrote:

> PCI Express/7042 Marvell Sata Card:
> ===================================
>    On PCI Express Bus - it never performs the probe - even though
>    the bus was scanned and device was found ("lspci" shows this device)
> 
>    FYI, I tried the PCI Express SATA Card in an X86 running Fedora
>    Core 6 (2.6.19.1-2xxx) and this seemingly is the same behavior
>    on this platform?

A patch went into 2.6.20 quite late to add the PCI ids for at least
one 7042 controller (Highpoint). You might have to add the ids of your
controller as well.


-Olof
