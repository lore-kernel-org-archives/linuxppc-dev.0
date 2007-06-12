Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <18030.32673.259326.715305@cargo.ozlabs.ibm.com>
Date: Tue, 12 Jun 2007 21:12:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 01/10] powerpc: split out CPU specific options into a new
	Kconfig file
In-Reply-To: <200706120942.48045.arnd@arndb.de>
References: <20070611232824.489103547@arndb.de>
	<20070611233353.602822721@arndb.de>
	<20070612140214.1a7dfd9d.sfr@canb.auug.org.au>
	<200706120942.48045.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann writes:

> On Tuesday 12 June 2007, Stephen Rothwell wrote:
> >   On Tue, 12 Jun 2007 01:28:25 +0200 arnd@arndb.de wrote:
> > >
> > > -config VIRT=5FCPU=5FACCOUNTING
> > > -=A0=A0=A0=A0=A0bool "Deterministic task and CPU time accounting"=

> >=20
> > I am not sure that this belongs with all the rest.
>=20
> It's selected by arch/powerpc/platforms/embedded6xx/Kconfig.

Where=3F  I don't see it.  VIRT=5FCPU=5FACCOUNTING is a 64-bit only opt=
ion,
at least until someone implements it for 32-bit.

Paul.
