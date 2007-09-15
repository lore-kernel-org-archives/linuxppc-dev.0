Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id A0007DDDE4
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 11:07:27 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] add Kconfig option for optimizing for cell
Date: Sat, 15 Sep 2007 03:02:52 +0200
References: <200709150221.57825.arnd@arndb.de>
	<7268aef0e0f5d31dc4d07d583406a6af@kernel.crashing.org>
In-Reply-To: <7268aef0e0f5d31dc4d07d583406a6af@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709150302.52346.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 15 September 2007, Segher Boessenkool wrote:
>=20
> > +config TUNE_CELL
> > +=A0=A0=A0=A0=A0bool "Optimize for Cell Broadband Engine"
> > +=A0=A0=A0=A0=A0depends on PPC64
> > +=A0=A0=A0=A0=A0help
> > +=A0=A0=A0=A0=A0 =A0Cause the compiler to optimize for the PPE of the C=
ell Broadband
> > +=A0=A0=A0=A0=A0 =A0Engine. This will make the code run considerably fa=
ster on Cell
> > +=A0=A0=A0=A0=A0 =A0but somewhat slower on other machines. This option =
only changes
> > +=A0=A0=A0=A0=A0 =A0the scheduling of instructions, not the selection o=
f instructions
> > +=A0=A0=A0=A0=A0 =A0itself,
>=20
> It _does_ change instruction selection, which is the main factor
> in the slowdown on other machines (and a big part of the speedup
> on Cell, too). =A0It doesn't change which insns the compiler is
> allowed to use though, which is probably what you wanted to say?

Right, thanks for the correction.

	Arnd <><
