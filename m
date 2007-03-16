Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id DE19CDDDCA
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 17:58:31 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2G6wQ92025198
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 23:58:27 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2G6wPa6016375
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 01:58:26 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: arch/powerpc Kconfig cleanup
Date: Fri, 16 Mar 2007 14:59:53 +0800
Message-ID: <989B956029373F45A0B8AF02970818902DB231@zch01exm26.fsl.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0703151816370.3448@localhost.localdomain>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> arch/powerpc/Kconfig has become something of a mess and platform
support
> is scattered between it and various arch/powerpc/platforms/*/Kconfig
> files.  I've got some ideas on some simple clean up that will
introduce a
> arch/powerpc/platforms/Kconfig and pull out platform config
information
> from arch/powerpc/Kconfig.
>=20
> Beyond general cleanup, there are several config options that should
> exist under the "Platform support" menu but end up getting duplicated
> across sub-architectures (QE, CPM2, etc.)
>=20
> By introducing a platforms/Kconfig we will have a place to put those
> config options so we don't have to duplicate them.

Sounds good to me.

- Leo
