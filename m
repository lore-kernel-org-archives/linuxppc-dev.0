Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 2D2E0DE031
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 16:59:12 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/14] ps3: system bus minor mmio fix
Date: Thu, 25 Jan 2007 06:59:05 +0100
References: <45B81877.3020600@am.sony.com>
In-Reply-To: <45B81877.3020600@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701250659.05829.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 January 2007 03:39, Geoff Levand wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> Fix two minor bugs in the PS3 system bus mmio region code. =A0First, on e=
rror or
> when freeing a region, retain the bus_addr and len fields to allow subseq=
uent
> calls to create the region. =A0Second, correct the region address argumen=
t to the
> lv1_unmap_device_mmio_region() call.
>=20
> Fixes modprobe/rmmod of some drivers.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>=20
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
