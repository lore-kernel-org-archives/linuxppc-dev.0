Message-ID: <3D5163B0.6326FF0C@broadcom.com>
Date: Wed, 07 Aug 2002 11:15:12 -0700
From: "James Dougherty" <jfd@broadcom.com>
MIME-Version: 1.0
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linuxppc-embedded@lists.linuxppc.org, jfd@broadcom.com,
	mchan@broadcom.com
Subject: Re: Tigon3 driver, broadcom 5307, 440GP, working?
References: <45B36A38D959B44CB032DA427A6E10640167D01C@cceexc18.americas.cpqcorp.net>
Content-Type: text/plain;
 charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

AFAIK, the TIGON3 driver in the latest 2_4_devel kernel does
not work with 5703. I did a code review of both the broadcom
and tigon3 driver and found that the open-source driver doesn't
have all the workarounds and, it doesn't support all the chips/board
flavors that are out there...

This brings up the bigger question of why people aren't using
the Broadcom OpenSource driver? I've used it successfully now
with all the latest chips (5700, 5701, 5703).

What does it take to add BSP and driver support to the 2_4_devel
tree?

			Thanks,
			-James


>
> On Wed, Jul 24, 2002 at 01:29:23PM -0500, I wrote:
> >
> > I've been playing around with the tigon3 driver and a broadcom
> > 5307 gigabit NIC in my IBM ebony... No luck so far.  The driver compiles
> > and even loads, I can run ifconfig(busybox really) to configure
> > the NIC,  and if I pull the network cable, the driver seems to
> > notice (get log messages about link is down, link is up) but so
> > far, I can't actually transmit or receive any packets.
> >
> > Anyone had any luck with this combination?
>
> Ok, I have determined that my problem lies in user-land, not
> the kernel.  Using the same kernel, but with a more elaborate
> start-up scripts/root filesystem (those from DENX ELDK-1.0)
> it works fine.
>
> Using my minimal rootfs, with busybox, tinylogin, it doesn't
> work.  Is there anything needed to get the broadcom 5703 going
> besides ifconfig?
>
> Well, I now have a root filesystem that works and one that
> doesn't so I can slowly make one more like the other until
> I see which piece is the culprit/magic.
>
> Thanks,
>
> -- steve
>

--
James F. Dougherty, III
Broadcom Corporation
jfd@broadcom.com
(408) 501-8273


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
