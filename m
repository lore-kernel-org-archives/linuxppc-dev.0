Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 08769DDDE9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 18:39:29 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.sysgo.com (Postfix) with ESMTP id EFB7ECC0EF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 08:39:25 +0100 (CET)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mail.sysgo.com (Postfix) with ESMTP id A3D4ACC0D2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 08:39:25 +0100 (CET)
Received: from gja.ulm.sysgo.com (unknown [172.30.1.130])
	by donald.sysgo.com (Postfix) with ESMTP id 9A49B287099
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Feb 2007 08:39:25 +0100 (CET)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Could not create MTD Partitions
Date: Wed, 28 Feb 2007 08:39:24 +0100
References: <29DC34A6B43468409F5A371CFE34E8490B614F@ex01.ads.ubidyne.de>
	<CB39D235-9A02-4FB3-B19E-D7928F0E44E2@kernel.crashing.org>
In-Reply-To: <CB39D235-9A02-4FB3-B19E-D7928F0E44E2@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Message-Id: <200702280839.24791.g.jaeger@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Dienstag, 27. Februar 2007, Kumar Gala wrote:
>=20
> On Feb 27, 2007, at 3:48 AM, Frank Prepelica wrote:
>=20
> > Hi all,
> >
> >
> >
> > I got a problem during creating the MTD partitions. I=92m using the
> > ELDK 4.1 with 2.6.19.2 Kernel and the MPC8343 board with 128MB RAM
> > and 64MB flash memory.
>=20
> Are you sure its a single flash chip that is 64M or multiple flash =20
> chips?

IIRC this board has 2 16-bit flash chips acting as one using 32-bit
access. Therefore you'll need to set the bankwidth correctly.

HTH
Gerhard

=2D-=20
Gerhard Jaeger <gjaeger@sysgo.com>           =20
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de=20
