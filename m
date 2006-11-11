Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id BAF2D67F18
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 13:03:30 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/16] spufs: change ppc_rtas declaration to weak
Date: Sat, 11 Nov 2006 03:03:25 +0100
References: <4554DA5E.3010103@am.sony.com>
In-Reply-To: <4554DA5E.3010103@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611110303.25518.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 10 November 2006 21:00, Geoff Levand wrote:
> Change the definition of powerpc's cond_syscall() to use the standard gcc
> weak attribute specifier which provides proper support for C linkage as
> needed by spu_syscall_table[].
>=20
> Fixes this powerpc build error with CONFIG_SPU_FS=3Dy, CONFIG_PPC_RTAS=3D=
n:
>=20
> =A0arch/powerpc/platforms/built-in.o: undefined reference to `ppc_rtas'
>=20
>=20
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
>=20

Acked-by: Arnd Bergmann <arnd@arndb.de>
