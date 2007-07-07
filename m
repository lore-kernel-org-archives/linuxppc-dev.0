Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 3A896DE043
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Jul 2007 22:22:16 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] [ide] mmio ide support
Date: Sat, 7 Jul 2007 14:19:52 +0200
References: <20070707094852.9473.21013.stgit@localhost.localdomain>
In-Reply-To: <20070707094852.9473.21013.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707071419.52650.arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 07 July 2007, Vitaly Bordug wrote:
>=20
> This adds support for MMIO IDE device like CompactFlash=20
> in TrueIDE mode.
> =A0
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>=20
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>

Hmm, are we still adding new IDE drivers? Do you also have a
driver for the new libata layer? I think it would even be
simpler to do.

You could also make it an of_platform_driver at the same time
instead of adding more cruft to fsl_soc.c. Since we're already
about to add the electra_ide.c driver in 2.6.23, I guess there
should really be _one_ driver that is able to handle all
of_device based ATA hosts.

	Arnd <><
