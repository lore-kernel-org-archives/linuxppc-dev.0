Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE004.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 150CCDDF74
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Sep 2008 01:23:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: EDK10.1 and emaclite
Date: Tue, 9 Sep 2008 09:23:11 -0600
In-Reply-To: <48C62603.7080606@team-ctech.de>
References: <48C5F6ED.4000804@cdac.in> <48C62603.7080606@team-ctech.de>
From: John Linn <John.Linn@xilinx.com>
To: "Georg Schardt" <schardt@team-ctech.de>,
	"Neeraj Garg" <neerajg@cdac.in>
Message-ID: <20080909152313.1CE1C17B8057@mail25-va3.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Georg,

There is no way to configure the PHY using the EMAC lite as that's part
of what makes it "lite".  =


So the PHY on the board has to be configured correctly by strapping it
on the board.

Maybe you can include other PHY drivers to do this as I'm not sure about
that.

Thanks,
John


> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Georg Schardt
> Sent: Tuesday, September 09, 2008 1:30 AM
> To: Neeraj Garg
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: EDK10.1 and emaclite
> =

> Hi again,
> =

> mmh, there is no kernel message with PHY detection, but all PHY
drivers
> are compiled in.
> i looked at my xps project and there is only one ip-core
"Ethernet_MAC"
> with type "xps_ethernetlite".
> is it possible that the phy connection is missing ? i use the base
> system builder with the board support files supported from avnet.
> =

> where can i look for the ethernet speed ? the ethernetlite ip has no
> speed options
> =

> thanks for your help
> georg
> =

> Neeraj Garg wrote:
> > Hi Georg,
> >
> > Can you post linux bootup message where its says PHY is detected at
> > paticular address, and check with your hardware what is actual
address
> > of PHY. Also I would like to know the configuration of your hardware
> > whether its configured of 10MBPS OR 100MBPS.
> >
> >
> >
------------------------------------------------------------------------
------------------
> >
> > --
> > Neeraj Garg
> >
> >
> >
> > Message: 3
> > Date: Mon, 08 Sep 2008 18:29:53 +0200
> > From: Georg Schardt <schardt@team-ctech.de>
> > Subject: EDK10.1 and emaclite
> > To: linuxppc-embedded@ozlabs.org
> > Message-ID: <48C55301.4070208@team-ctech.de>
> > Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed
> >
> > Hi all,
> >
> > im trying to use the emaclite core which comes with the EDK10.1 with
> > the 2.6.26 kernel from git.xilinx.com on virtex4fx12 minimodul. the
> > emac is detect by the kernel:
> >
> > xilinx_emaclite xilinx_emaclite.0: MAC address is now  2: 0: 0: 0:
0: 0
> > xilinx_emaclite xilinx_emaclite.0: using fifo mode.
> > xilinx_emaclite xilinx_emaclite.0: Xilinx EMACLite at 0x81000000
> > mapped to 0xC5060000, irq=3D0
> >
> > i can change the mac-address with ifconfig and i can give an
> > ip-address to the device,
> > but a ping is not possible and arp is not working. i think that the
> > phy is not working right.
> >
> > has someone others the same problem ? what can i changed ? i have
> > tried out all possible phy driver in the linux  kernel
> >
> > a setup with the lltemac is working fine, but i want to use the
emaclite
> >
> > thanks
> > regards
> > georg
> >
> =

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
