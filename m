Message-ID: <396AEAC7.D8CACCB2@agelectronics.co.uk>
Date: Tue, 11 Jul 2000 10:37:11 +0100
From: Adrian Cox <apc@agelectronics.co.uk>
MIME-Version: 1.0
To: Matt Porter <mmporter@home.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Going from 2.2.12 to 2.2.17pre10
References: <20000709222943.A19611@cx258813-a.chnd1.az.home.com> <Pine.HPX.4.10.10007101412580.9548-100000@gra-ux1.iram.es> <20000710225720.A23538@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Matt Porter wrote:
> Back to original point, I'm not against using a residual data or
> device tree if it doesn't have to have dozens of fixups applied.
> I just don't see that coming out of the proprietary hardware/software
> houses to use their broken data...

Residual data is useful for things like finding the memory size, and for
chips designed inside Apple. For almost everything else Linux already
contains a device tree, built by PCI probing when the kernel boots^*. I
don't see much need for a parallel, architecture specific, device tree.

- Adrian Cox, AG Electronics
*) Apologies to MCA and Nubus users.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
