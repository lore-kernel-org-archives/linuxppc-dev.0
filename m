Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 6364CDDF47
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 07:08:26 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Allow exec on 32-bit from readable, non-exec pages,
	with a warning.
Date: Mon, 9 Jul 2007 22:25:24 +0200
References: <20070709195743.GA26089@ld0162-tx32.am.freescale.net>
In-Reply-To: <20070709195743.GA26089@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707092225.25287.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 09 July 2007, Scott Wood wrote:
> In older versions of glibc (through 2.3), the dynamic linker executes a
> small amount of code from the data segment, which is not marked as
> executable. =A0A recent change (commit 9ba4ace39fdfe22268daca9f28c5df384a=
e462cf)
> stops this from working; there should be a deprecation period before
> older glibc versions stop working.
>=20
> The problem has been observed on glibc 2.2. =A0While glibc 2.3 has the sa=
me
> code, I did not see the problem; it may be that it accesses the page in
> question as data before executing from it, and thus it is already mapped.

I may be missing the obvious, but doesn't that defeat the purpose of
non-executable mappings?

	Arnd <><
