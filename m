Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 4651ADDEF3
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 17:46:32 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 06/10] powerpc: multiplatformize embedded6xx Kconfig
Date: Tue, 12 Jun 2007 09:46:22 +0200
References: <20070611232824.489103547@arndb.de>
	<20070611233354.289486461@arndb.de>
	<F72846CE-5742-4413-A2EB-AC1B4080048E@kernel.crashing.org>
In-Reply-To: <F72846CE-5742-4413-A2EB-AC1B4080048E@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706120946.22401.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 12 June 2007, Kumar Gala wrote:
> > -config EMBEDDED6xx
> > -=A0=A0=A0=A0=A0bool "Embedded 6xx/7xx/7xxx-based board"
> > -=A0=A0=A0=A0=A0depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
> > -
>=20
> Do we know why this was marked BROKEN?

I don't know. As far as I can tell, (BROKEN||BROKEN_ON_SMP) is the
same as simply BROKEN_ON_SMP, which makes the option only show
up when SMP is disabled.

My patch doesn't change that behaviour, I just moved the dependency
down to the individual boards.

	Arnd <><
