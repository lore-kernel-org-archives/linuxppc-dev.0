Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id C896467BAC
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Dec 2006 09:06:47 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH] cell: fix missing spu.h header export
Date: Tue, 5 Dec 2006 23:06:42 +0100
References: <4575E712.5020103@am.sony.com>
In-Reply-To: <4575E712.5020103@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612052306.42632.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 05 December 2006 22:39, Geoff Levand wrote:
>=20
> Add spu.h to the list of exported headers. =A0Fixes this error when
> using 'make headers_check' or when CONFIG_HEADERS_CHECK=3Dy:
>=20
> =A0 asm/spu_info.h requires asm/spu.h, which does not exist in exported h=
eaders
>=20
>=20
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Sorry, wrong fix. I had a better one already but haven't gotten around
to post it. spu_info.h should be in unifdef-y and spu.h should stay
internal to the kernel. I'll follow up with my patch.

	Arnd <><
