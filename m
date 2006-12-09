Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id E7DC367B8F
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 23:18:39 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ps3: add vuart support
Date: Sat, 9 Dec 2006 13:18:23 +0100
References: <45775D89.7030904@am.sony.com> <457A1F23.1020207@am.sony.com>
In-Reply-To: <457A1F23.1020207@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612091318.23993.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 09 December 2006 03:27, Geoff Levand wrote:
> Adds support for the PS3 virtual UART (vuart). =A0The vuart provides a
> bi-directional byte stream data link between logical partitions.
>=20
> This is needed for the ps3 graphics driver and the ps3 power
> control support to be able to communicate with the lv1 policy
> module.
>=20
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
