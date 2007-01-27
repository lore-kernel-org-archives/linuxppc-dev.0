Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 7DD23DE087
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 22:26:56 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 10/16] ps3: add interrupt alloc for outlets
Date: Sat, 27 Jan 2007 12:26:49 +0100
References: <45BAC21C.7000104@am.sony.com>
In-Reply-To: <45BAC21C.7000104@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701271226.49529.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 27 January 2007 04:08, Geoff Levand wrote:
> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>=20
>=20
> PS3 interrupt core update:
> =A0 - Add ps3_alloc_irq() and ps3_free_irq(), to allocate a virtual inter=
rupt
> =A0 =A0 number for an interrupt outlet, which is needed by the PS3 GPU fr=
ame
> =A0 =A0 buffer device and audio drivers
>=20
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>=20
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
