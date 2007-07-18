Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 020A1DDE30
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 08:54:37 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] fix future firmware feature fixups function failure
Date: Thu, 19 Jul 2007 00:54:16 +0200
References: <9094.1181275235@neuling.org> <200707111329.51580.arnd@arndb.de>
	<24414.1184795792@neuling.org>
In-Reply-To: <24414.1184795792@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200707190054.17754.arnd@arndb.de>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 18 July 2007, Michael Neuling wrote:
> Move firmware feature initialisation from pSeries_init_early to the
> earlier pSeries_probe_hypertas so they are initialised before firmware
> feature fixups are applied.
>=20
> Currently firmware feature sections are only used for iSeries which
> initialises the these features much earlier. =A0This is a bug in waiting
> on pSeries.
>=20
> Also adds some whitespace fixups.
>=20
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Haven't tested it myself, but it certainly looks good to me. It does
require reverting your previous patch though, are you submitting the
reversal patch as well?

	Arnd <><
