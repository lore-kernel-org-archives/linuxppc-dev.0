Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id A76C5DDECF
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 05:36:13 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Add 83xx and 86xx to 6xx Multiplatform
Date: Fri, 27 Jun 2008 21:35:46 +0200
References: <Pine.LNX.4.64.0806271136240.20344@blarg.am.freescale.net>
	<20080627180423.GB12627@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080627180423.GB12627@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806272135.47167.arnd@arndb.de>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 27 June 2008, Scott Wood wrote:
> On Fri, Jun 27, 2008 at 11:36:36AM -0500, Kumar Gala wrote:
> > There isn't any reason at this point that we can't build 83xx & 86xx su=
pport
> > in with the other 6xx based boards. =A0Twiddle the Kconfigs to allow th=
is.
>=20
> Likewise with 82xx -- why don't we just get rid of the "Machine type"
> choice, and turn them all into bools?

I started looking for possible problems with hardcoded settings for some
of the platforms, and the only code that looked suspicious in this regard
was CPM2, but it turned out that this was all because of code built without
CONFIG_PPC_CPM_NEW_BINDING, which is practically gone in kumar's powerpc-ne=
xt
branch.

	Arnd <><
