Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 8100BDDEF2
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 07:35:08 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
Date: Mon, 9 Jul 2007 22:52:09 +0200
References: <20070709195743.GA26089@ld0162-tx32.am.freescale.net>
	<200707092225.25287.arnd@arndb.de> <4692A5B8.9010702@freescale.com>
In-Reply-To: <4692A5B8.9010702@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707092252.09795.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 09 July 2007, Scott Wood wrote:
> The hardware in question doesn't support non-executable mappings;=20
> otherwise, it'd never have worked in the first place. =A0Note that this i=
s=20
> only allowed on 32-bit, non-book-E.
>=20
> There isn't much value in enforcing non-exec mappings only if it happens=
=20
> to be the first fault on a given page.

Ok, much clearer now. Do you mind adding that explanation to the
changelog text? If it's going into the stable kernel update, there
may be more people reading this with the same problem understanding
the patch.

	Arnd <><
