Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 471ABDDF38
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Sep 2008 22:51:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "=?iso-8859-15?q?S=E9bastien?= =?iso-8859-15?q?_Chr=E9tien?="
	<sebastien.chretien.enseirb@gmail.com>
Subject: Re: IDE
Date: Wed, 10 Sep 2008 14:51:07 +0200
References: <319b0ac50809100224w2073359aod42c843cd5696599@mail.gmail.com>
	<200809101304.51990.arnd@arndb.de>
	<319b0ac50809100523t17da1035l95c67808bd75088@mail.gmail.com>
In-Reply-To: <319b0ac50809100523t17da1035l95c67808bd75088@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200809101451.07418.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 10 September 2008, S=E9bastien Chr=E9tien wrote:
> I looked falconide.c, it uses     hw_regs_t hw; and ide_hwif_t *hwif.
> Is it a good way ?
>=20

No, that uses the legacy IDE drivers, not the current ATA drivers,
and it is not based on the device tree information.

Just use drivers/ata/pata_of_platform.c, you probably don't even
need to change the code, just your device tree.

	Arnd <><
