Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id A270A67B83
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 16:34:17 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k6I6YDSN019805
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Jul 2006 23:34:13 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k6I6Y9wg005373
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 01:34:12 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [linux-usb-devel] [PATCH] Add USB to MPC8349 PB platform support
Date: Tue, 18 Jul 2006 14:34:29 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0509A9@zch01exm20.fsl.freescale.net>
In-Reply-To: <200607171557.50368.david-b@pacbell.net>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "David Brownell" <david-b@pacbell.net>,
	<linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Tuesday, July 18, 2006 6:58 AM
> To: linux-usb-devel@lists.sourceforge.net
> Cc: Hollis Blanchard; Kumar Gala; linuxppc-dev@ozlabs.org; Li
Yang-r58472
> Subject: Re: [linux-usb-devel] [PATCH] Add USB to MPC8349 PB platform
support
>=20
> On Monday 17 July 2006 1:08 pm, Hollis Blanchard wrote:
> >
> > Seems to me that it's far better to have init code in the kernel
than
> > firmware.
>=20
> If there's a general Linux policy on the issue, I think that'd be it.

Do we have a general policy for this now?
>=20
> Plus, remember that boot firmware _can't_ always be changed/bugfixed;
> sometimes it can, but not as a general rule.
>=20
> - Dave
>=20
>=20
> > For one example, look at the x86 video card init problem
> > PowerPC Linux has. It's also far easier to fix/deploy Linux code
than
> > firmware code, as Li observed, and on top of that it's less work for
> > non-UBoot firmwares in the future.
> >
> > -Hollis
> >
