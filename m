Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 8A574DDF60
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 22:16:23 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Please pull powerpc.git 'merge' branch
Date: Wed, 20 Dec 2006 12:15:47 +0100
References: <17801.3873.941944.129198@cargo.ozlabs.ibm.com>
	<1166611943.5144.5.camel@localhost.localdomain>
In-Reply-To: <1166611943.5144.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612201215.48542.arnd@arndb.de>
Cc: torvalds@osdl.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 20 December 2006 11:52, Benjamin Herrenschmidt wrote:
>=20
> > Jens Osterkamp (1):
> > =A0 =A0 =A0 [POWERPC] cell: Enable spider workarounds on all PCI buses
>=20
> That one isn't totally correct I think, but it can go in, it won't harm,
> it's just that the PCIe busses on the spider chip might need a slightly
> different workaround. I'll send a separate patch on top of this one to
> fix it.

Thanks. I thought that a fix for the PCIe bus had already gone in.
Once you have done it, Jens' patch will be the the right one.

	Arnd <><
