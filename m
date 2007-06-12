Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 3B235DDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 22:43:07 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 01/10] powerpc: split out CPU specific options into a new
	Kconfig file
Date: Tue, 12 Jun 2007 14:42:52 +0200
References: <20070611232824.489103547@arndb.de>
	<200706120942.48045.arnd@arndb.de>
	<18030.32673.259326.715305@cargo.ozlabs.ibm.com>
In-Reply-To: <18030.32673.259326.715305@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706121442.53211.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 June 2007, Paul Mackerras wrote:
> > On Tuesday 12 June 2007, Stephen Rothwell wrote:
> > > =A0 On Tue, 12 Jun 2007 01:28:25 +0200 arnd@arndb.de wrote:
> > > >
> > > > -config VIRT_CPU_ACCOUNTING
> > > > -=A0=A0=A0=A0=A0bool "Deterministic task and CPU time accounting"
> > >=20
> > > I am not sure that this belongs with all the rest.
> >=20
> > It's selected by arch/powerpc/platforms/embedded6xx/Kconfig.
>=20
> Where? =A0I don't see it. =A0VIRT_CPU_ACCOUNTING is a 64-bit only option,
> at least until someone implements it for 32-bit.

Sorry, I was confusing this with CONFIG_CHECK_CACHE_COHERENCY for
some weird reason.

My patch moves the entire CPU selection menu to a new file, without
changing any of the contents. If you like, I can add another
patch that moves VIRT_CPU_ACCOUNTING into the platform support or
the general setup menu.

	Arnd <><
