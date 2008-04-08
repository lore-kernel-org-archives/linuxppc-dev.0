Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id E2909DDE22
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 12:14:57 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Question on mpc52xx_common.c
Date: Tue, 8 Apr 2008 04:14:42 +0200
References: <m21w5map5f.fsf@ohwell.denx.de>
	<fa686aa40804031200n4cd7aeb4g330ab3e2620680e@mail.gmail.com>
	<47FAA0A8.7050602@genesi-usa.com>
In-Reply-To: <47FAA0A8.7050602@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804080414.42867.arnd@arndb.de>
Cc: Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 April 2008, Matt Sealey wrote:
> Grant Likely wrote:
> >=20
> > Sure, why not? =A0If the firmware has already set it up correctly and no
> > devices using it are in use, then the kernel should be okay. =A0:-)
> > That said, I can't imagine choosing to not put the cdm node into the
> > device tree.
>=20
> *ahem* Efika.

Maybe we should just give up on making the efika boot with its regular
device tree and instead add a boot wrapper that either fixes up the
data provided by its firmware or just adds a proper dt blob?

	Arnd <><
