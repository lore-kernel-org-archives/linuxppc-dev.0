Return-Path: <John.Linn@xilinx.com>
Received: from VA3EHSOBE005.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id 22010DDF64
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Sep 2008 08:25:43 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: EDK10.1 and emaclite
Date: Mon, 8 Sep 2008 16:25:36 -0600
In-Reply-To: <48C55301.4070208@team-ctech.de>
References: <48C55301.4070208@team-ctech.de>
From: John Linn <John.Linn@xilinx.com>
To: "Georg Schardt" <schardt@team-ctech.de>,
	<linuxppc-embedded@ozlabs.org>
Message-ID: <20080908222538.E4A138B0057@mail13-va3.bigfish.com>
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

I don't really know much about the state of the emac lite driver in the
Git tree. I inherited the Git tree with some stuff already in it.

I test the LL TEMAC driver, but haven't had the bandwidth and priority
to do any emac lite testing.

Thanks,
John

> -----Original Message-----
> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
[mailto:linuxppc-embedded-
> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Georg Schardt
> Sent: Monday, September 08, 2008 10:30 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: EDK10.1 and emaclite
> =

> Hi all,
> =

> im trying to use the emaclite core which comes with the EDK10.1 with
the
> 2.6.26 kernel from git.xilinx.com on virtex4fx12 minimodul. the emac
is
> detect by the kernel:
> =

> xilinx_emaclite xilinx_emaclite.0: MAC address is now  2: 0: 0: 0: 0:
0
> xilinx_emaclite xilinx_emaclite.0: using fifo mode.
> xilinx_emaclite xilinx_emaclite.0: Xilinx EMACLite at 0x81000000
mapped
> to 0xC5060000, irq=3D0
> =

> i can change the mac-address with ifconfig and i can give an
ip-address
> to the device,
> but a ping is not possible and arp is not working. i think that the
phy
> is not working right.
> =

> has someone others the same problem ? what can i changed ? i have
tried
> out all possible phy driver in the linux  kernel
> =

> a setup with the lltemac is working fine, but i want to use the
emaclite
> =

> thanks
> regards
> georg
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
