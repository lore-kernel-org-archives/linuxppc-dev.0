MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Tigon3 driver, broadcom 5307, 440GP, working?
Date: Wed, 7 Aug 2002 11:05:12 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167D01C@cceexc18.americas.cpqcorp.net>
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jul 24, 2002 at 01:29:23PM -0500, I wrote:
>
> I've been playing around with the tigon3 driver and a broadcom
> 5307 gigabit NIC in my IBM ebony... No luck so far.  The driver compiles
> and even loads, I can run ifconfig(busybox really) to configure
> the NIC,  and if I pull the network cable, the driver seems to
> notice (get log messages about link is down, link is up) but so
> far, I can't actually transmit or receive any packets.
>
> Anyone had any luck with this combination?

Ok, I have determined that my problem lies in user-land, not
the kernel.  Using the same kernel, but with a more elaborate
start-up scripts/root filesystem (those from DENX ELDK-1.0)
it works fine.

Using my minimal rootfs, with busybox, tinylogin, it doesn't
work.  Is there anything needed to get the broadcom 5703 going
besides ifconfig?

Well, I now have a root filesystem that works and one that
doesn't so I can slowly make one more like the other until
I see which piece is the culprit/magic.

Thanks,

-- steve

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
