Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id ABF82DE367
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Aug 2008 01:27:19 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC 2/3] powerpc: export all symbols from the definition file
Date: Mon, 11 Aug 2008 17:27:07 +0200
References: <200808111606.44103.arnd@arndb.de>
	<200808111617.53305.arnd@arndb.de>
	<Pine.LNX.4.64.0808111653170.3030@vixen.sonytel.be>
In-Reply-To: <Pine.LNX.4.64.0808111653170.3030@vixen.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200808111727.07720.arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 11 August 2008, Geert Uytterhoeven wrote:
> > =A0drivers/macintosh/adb.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A05 +++++
> > =A0drivers/macintosh/via-cuda.c =A0 =A0 =A0 =A0 | =A0 =A03 +++
>=20
> I think these 2 belong to patch 3?

I tried to come up with other ways of splitting up the patch,
but since these come from ppc_ksyms, it makes sense to keep
them with the rest.

Maybe I could split the exports for C functions from those
in assember files that depend on patch 1.

	Arnd <><
