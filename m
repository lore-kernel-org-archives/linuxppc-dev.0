Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 3966DDDE0E
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 06:16:35 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/3] Remove need for include/asm-ppc
Date: Fri, 17 Aug 2007 19:06:54 +0200
References: <Pine.LNX.4.64.0708170157140.15311@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0708170157140.15311@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708171906.54711.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 17 August 2007, Kumar Gala wrote:
> This patch series removes the need for include/asm-ppc in the ARCH=3Dpowe=
rpc
> build for ppc32. =A0They exist in the following git tree:
>=20
> =A0 master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6=
=2E24
>=20
> posting here for everyone else to see.

Cool stuff. At one point I started doing a partial version of your patch 1/=
3,
but gave up soon when it grew too big.

	Arnd <><
