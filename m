Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 9A8DFDDE2E
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2007 06:52:00 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] [POWERPC] Copy over headers from arch/ppc to
	arch/powerpc that we need
Date: Fri, 17 Aug 2007 19:42:25 +0200
References: <Pine.LNX.4.64.0708170157140.15311@blarg.am.freescale.net>
	<Pine.LNX.4.64.0708170213040.15311@blarg.am.freescale.net>
	<200708171905.52855.arnd@arndb.de>
In-Reply-To: <200708171905.52855.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708171942.25914.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 17 August 2007, Arnd Bergmann wrote:
> The m8260_pci.h file is not namespace clean, it defines macros like
> PCI_CFG_ADDR_REG that are likely to create conflicts at some point of
> time. Since the only file including this header is 
> arch/powerpc/platforms/82xx/m82xx_pci.h, I'd suggest merging the two,
> to make sure nobody can accidentally include it.

Upon closer inspection, none of the definitions in this file are
actually used in arch/powerpc, or should be.

So, can we just kill that file, as you did with the others in your
first patch?

	Arnd <><
