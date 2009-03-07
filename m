Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id C509EDDF19
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Mar 2009 13:01:28 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so370683yxb.39
	for <linuxppc-dev@ozlabs.org>; Fri, 06 Mar 2009 18:01:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090303081212.GL5367@pengutronix.de>
References: <20090301101815.GC23093@pengutronix.de>
	<9e4733910903010754q1b4d9fafy87668049653d5e21@mail.gmail.com>
	<fa686aa40903011447x1810f252m367d6c05cc567133@mail.gmail.com>
	<9e4733910903011637q246eb82al140e87242f695413@mail.gmail.com>
	<9e4733910903011646g43b151c2m7c6dfe80ac07e80a@mail.gmail.com>
	<fa686aa40903011707q3c142942w962c52abaf915629@mail.gmail.com>
	<9e4733910903011815q1a956be0x137bac80f2e21e72@mail.gmail.com>
	<9e4733910903011819q105a856n163ccd8fee37d980@mail.gmail.com>
	<fa686aa40903012033x6b6a76d6j7218d076f2c6ad3d@mail.gmail.com>
	<20090303081212.GL5367@pengutronix.de>
Date: Fri, 6 Mar 2009 21:01:25 -0500
Message-ID: <9e4733910903061801w3a9661acm3e8855abb743d3e0@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc52xx: add Phytec phyCORE-MPC5200B-IO board
	(pcm032)
From: Jon Smirl <jonsmirl@gmail.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Wolfram Sang <wsa@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 3, 2009 at 3:12 AM, Robert Schwebel
<r.schwebel@pengutronix.de> wrote:
> On Sun, Mar 01, 2009 at 09:33:16PM -0700, Grant Likely wrote:
>> On Sun, Mar 1, 2009 at 7:19 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> > Would it be easier to get Pengutronix to release a new u-boot for
>> > the pcm030? I'm using U-Boot 1.2.0-mpc5200b-tiny-2 (Apr 17 2007 -
>> > 11:49:20).
>>
>> Only if it is a chip IO setup problem (like port_config or clock
>> setup). Otherwise the kernel should be setting up the PCI controller
>> correctly. Regardless, I don't think the kernel should be crashing
>> when PCI is in a funny state.
>
> Ack; I didn't follow the thread in detail, but if possible I'd like to
> avoid bootloader updates; it's quite a lot of effort because there are
> thousends of devices in the field, not to mention the whole
> qualification mechanics at Phytec.

On a pcm030 1245-1
u-boot-1.2.0-mpc5200b-tiny-3,  boots ok and PCI is initialized correctly.

The readme is not clear that tiny-3 should be used on 1245.1 hardware.
http://www.pengutronix.de/oselas/bsp/phytec/download/phyCORE-MPC5200B-tiny/=
Readme

This phrase implies the tiny-3 should only be used on 1245.2 hardware.
"U-Boot binary to be used with
OSELAS.BSP-Phytec-phyCORE-MPC5200B-tiny-6 (board revision 1245.2)"

Where is the difference between the 1245.0, 1245.1 and 1245.2 hardware
documented?



>
> Wolfram can check the issue when being back in the office.
>
> rsc
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 =A0=
 =A0|
> Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 | Fax: =A0 +49-5121-=
206917-5555 |
>



--=20
Jon Smirl
jonsmirl@gmail.com
