Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 3E7BCDDF2C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Apr 2008 20:09:02 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: dhlii@dlasys.net
Subject: Re: HAVE_CONFIG
Date: Tue, 29 Apr 2008 12:03:42 +0200
References: <4816B372.10608@dlasys.net> <200804291127.14666.arnd@arndb.de>
	<4816F0CF.2080800@dlasys.net>
In-Reply-To: <4816F0CF.2080800@dlasys.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804291203.43239.arnd@arndb.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 29 April 2008, David H. Lynch Jr. wrote:
> Arnd Bergmann wrote:
> > On Tuesday 29 April 2008, David H. Lynch Jr. wrote:
> > =A0=20
> >> =A0 =A0 Why does CONFIG_PPC set CONFIG_HAVE_IDE ?
> >> =A0 =A0=20
> >
> > Because it's possible to build ide drivers on the powerpc architecture.
> > It means you get the option to enable to disable the old ATA (IDE) driv=
ers.
> >
> > =A0=A0=A0=A0=A0=A0Arnd <><
> > =A0=20
> =A0 =A0 So CONFIG_HAVE_IDE means the architecture could have IDE rather t=
han
> it does have IDE ?

Right.

> =A0 =A0 My BSP can't have IDE, does that mean I should add
> =A0 =A0
> =A0 =A0 default n if MYBSP
>=20
> =A0 =A0 ? or somehow deselect HAVE_IDE in the config option for my BSP ?

No.

You can always build multiplatform kernels, and your BSP Kconfig should do
nothing to forbid this. The only time where you don't want to set HAVE_IDE
is when it is impossible to build the IDE drivers. However, if your code
does not allow building support for IDE into the kernel, you should fix your
code rather than disable the Kconfig.

	Arnd <><
