Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 475B7DE067
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Feb 2008 03:50:42 +1100 (EST)
Date: Fri, 22 Feb 2008 10:50:01 -0600
From: Scott Wood <scottwood@freescale.com>
To: mahendra varman <mahendravarman15@gmail.com>
Subject: Re: Doubt in Device tree entry for USB on Powerpc based board
Message-ID: <20080222165001.GA19953@ld0162-tx32.am.freescale.net>
References: <4ac2955e0802220533o3eba0e58ybb72326ab0e1a376@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4ac2955e0802220533o3eba0e58ybb72326ab0e1a376@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Feb 22, 2008 at 07:03:07PM +0530, mahendra varman wrote:
> Please help me in the device tree where to give the device type
> compatibility address_cells size cells for the USB (since usb controller is
> in pci bridge i have some confusion in where to give the entry for usb)

You don't need to describe PCI devices in the device tree; they are
probed at runtime.

-Scott
