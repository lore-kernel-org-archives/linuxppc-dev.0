Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 8266F67B67
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 18:57:17 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k6798Q5D020308
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Jul 2006 02:08:26 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k678vDXj013226
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Jul 2006 03:57:14 -0500 (CDT)
Subject: RE: [PATCH 1/3] Freescale QE UCC gigabit ethernet driver
Date: Fri, 7 Jul 2006 16:59:35 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Message-ID: <4879B0C6C249214CBE7AB04453F84E4DF278@zch01exm20.fsl.freescale.net>
In-Reply-To: <FA983307-6A01-4FCB-A15A-ACC0E7B068A9@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org, jgarzik@pobox.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, July 06, 2006 9:45 PM
> To: Li Yang-r58472
> Cc: Andrew Morton; jgarzik@pobox.com; netdev@vger.kernel.org;
> linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 1/3] Freescale QE UCC gigabit ethernet driver
>=20
> Nack.  Here are some high level things that should be addressed:
> * There is a ton of debug code that should probably be stripped out,
> such as dump_regs, etc..

The reason I left these debug code in is that, QE is very flexible.
User probably needs to fine tune parameters for their own application.
It will be good to give them some clue doing that.  It's fine to remove
them, if you do think they are too verbose.
> * The phy support should use the phylib instead

I'll do this when I do get some time. ;)
> * convert from being a platform_device to of_device

I'm not up against moving to use of_device.  But why are we putting
extra effort in closing the door to backward compatibility with ppc
arch, and doesn't provide any new feature. ;)
>=20
> - kumar
>=20
