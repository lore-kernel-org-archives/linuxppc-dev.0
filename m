Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E90E8DE609
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 04:40:34 +1000 (EST)
Message-ID: <487B9D98.8010008@freescale.com>
Date: Mon, 14 Jul 2008 13:40:24 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>, Timur Tabi <timur@freescale.com>,
	Jon Smirl <jonsmirl@gmail.com>, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
Subject: Re: [alsa-devel] [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper
	for matching bus and codec drivers
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<9e4733910807140713r5739efedw81e65632006d101d@mail.gmail.com>
	<20080714150527.GD25448@sirena.org.uk>
	<487B7B71.9060606@freescale.com>
	<20080714165302.GG25448@sirena.org.uk>
	<fa686aa40807141021ka4f84e9ycc4ac78db760726c@mail.gmail.com>
	<20080714183632.GI25448@sirena.org.uk>
In-Reply-To: <20080714183632.GI25448@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark Brown wrote:

> Desktop Management Interface, a standard BIOS interface for getting
> system data on x86 class hardware.  Of particular interest here is the
> fact that it contains various ID strings for things like motherboard and
> chassis - on Linux drivers can be automatically loaded based on these
> strings.  See drivers/misc/thinkpad_acpi.c for an example of a driver
> that does this.

The only problem with this is that the OF probing code in the kernel binds
drivers to device tree nodes.  So when a driver claims a node, no other driver
will be probed with it.

So we can't have generic nodes that classify the motherboard and just let
everyone get probed on it.

-- 
Timur Tabi
Linux kernel developer at Freescale
