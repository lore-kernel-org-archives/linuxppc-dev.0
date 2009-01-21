Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id B9684DE16F
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 11:48:15 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: more printing warning fixes for the l64 to ll64
	conversion
Date: Wed, 21 Jan 2009 01:46:41 +0100
References: <20090121111651.7d6e87ec.sfr@canb.auug.org.au>
In-Reply-To: <20090121111651.7d6e87ec.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901210146.43379.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Nick Spence <nick.spence@freescale.com>,
	Scott Wood <scottwood@freescale.com>,
	Egor Martovetsky <egor@pasemi.com>, Doug@ozlabs.org,
	linux-mtd@lists.infradead.org,
	Thompson <dougthompson@xmission.com>, Johansson <olof@lixom.net>,
	Paul Mackerras <paulus@samba.org>, Olof@ozlabs.org,
	David Woodhouse <dwmw2@infradead.org>,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 21 January 2009, Stephen Rothwell wrote:
> =A0drivers/edac/cell_edac.c =A0 =A0 =A0 =A0 | =A0 =A08 ++++----
> =A0drivers/mtd/nand/fsl_elbc_nand.c | =A0 =A06 +++---
> =A0drivers/mtd/nand/pasemi_nand.c =A0 | =A0 =A04 ++--
> =A03 files changed, 9 insertions(+), 9 deletions(-)
>=20
> If noone minds (seeing as how simple this patch is) we could just merge
> it via the powerpc tree.

=46ine with me (cell_edac bits in particular).

Acked-by: Arnd Bergmann <arnd@arndb.de>
