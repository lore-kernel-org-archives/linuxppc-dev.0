Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 84B2EDDFF9
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 07:57:27 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Eval boards should not need to mess with ROOT_DEV
Date: Mon, 8 Oct 2007 23:57:12 +0200
References: <20071008151254.7777.38512.stgit@trillian.cg.shawcable.net>
	<fa686aa40710081203k13f921dcm4542299c0ecb401@mail.gmail.com>
	<fa686aa40710081406w4aa751ewddb6a164bc070871@mail.gmail.com>
In-Reply-To: <fa686aa40710081406w4aa751ewddb6a164bc070871@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710082357.13144.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 08 October 2007, Grant Likely wrote:
> Oh, and cell does too. =A0Geoff, does cell support really need to do this:
> (in cell/setup.c and celleb/setup.c).
> =A0=A0=A0=A0=A0=A0=A0=A0if (ROOT_DEV =3D=3D 0) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0printk("No ramdisk, defau=
lt root is /dev/hda2\n");
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ROOT_DEV =3D Root_HDA2;
> =A0=A0=A0=A0=A0=A0=A0=A0}
>=20
> If not; I'll spin a patch to drop it.

Cell certainly doesn't need this, I believe this is an artifact from
copying from pseries, so please kill it when you do the patch.

	Arnd <><
