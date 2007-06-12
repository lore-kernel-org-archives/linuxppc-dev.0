Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 6E59BDDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 17:43:01 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 01/10] powerpc: split out CPU specific options into a new
	Kconfig file
Date: Tue, 12 Jun 2007 09:42:47 +0200
References: <20070611232824.489103547@arndb.de>
	<20070611233353.602822721@arndb.de>
	<20070612140214.1a7dfd9d.sfr@canb.auug.org.au>
In-Reply-To: <20070612140214.1a7dfd9d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200706120942.48045.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 June 2007, Stephen Rothwell wrote:
>   On Tue, 12 Jun 2007 01:28:25 +0200 arnd@arndb.de wrote:
> >
> > -config VIRT_CPU_ACCOUNTING
> > -=A0=A0=A0=A0=A0bool "Deterministic task and CPU time accounting"
>=20
> I am not sure that this belongs with all the rest.

It's selected by arch/powerpc/platforms/embedded6xx/Kconfig.
How about moving it to arch/powerpc/platforms/Kconfig?

	Arnd <><
