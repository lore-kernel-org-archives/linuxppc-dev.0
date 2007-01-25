Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 642F5DE027
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 16:58:42 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/14] ps3: repository storage support
Date: Thu, 25 Jan 2007 06:58:36 +0100
References: <45B81870.4010302@am.sony.com>
In-Reply-To: <45B81870.4010302@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701250658.36299.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 January 2007 03:39, Geoff Levand wrote:
> From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
>=20
> Handle storage-related repository data:
> =A0 - Add missing implementations of ps3_repository_read_stor_*() reposit=
ory
> =A0 =A0 accessors.
> =A0 - Dump storage properties in debug mode
> =A0 - Add PS3_DEV_TYPE_STOR_PDISK,ROM,FLASH} device types (which are iden=
tical to
> =A0 =A0 the corresponding SCSI device types) to enum ps3_dev_type
>=20
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>=20
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
