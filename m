Message-Id: <5.1.0.14.2.20030424134156.036e1e80@falcon.si.com>
Date: Thu, 24 Apr 2003 13:44:43 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Subject: Re: boot/simple in ROM?
In-Reply-To: <00032EDD.C22236@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The "simple" boot loaders are loaders, they are NOT bootroms.  They expect
the board to have a firmware/bootrom/monitor that does the necessary very
low level very hardware specific initialization (things like setting up
memory maps, initializing the SDRAM controller, etc.).  The "simple" boot
loaders do the added steps necessary for starting linux, so they are
necessary but NOT sufficient.

gvb


At 01:32 PM 4/24/2003 -0400, kentborg@borg.org wrote:

>On Thu, Apr 24, 2003 at 01:13:35PM -0400, Dan Malek wrote:
> > The other really nice thing about these bootloaders, compressed
> > kernels, and attached initrd, is you can boot the identical image
> > from all "devices."  For example, during development you can tftp
> > load the image, get everything working, then place the exact same
> > bits into a flash rom.  Simply jump to the first location of the
> > image and it will boot from flash.
>
>Yes, but disappointingly the ppc/boot/simple I am using (from 2.4
>devel) won't run from ROM.  Is there a better boot loader I should be
>using?
>
>Thanks,
>
>-kb
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
