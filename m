Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 497FEDDED9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 17:59:12 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 12/13] powerpc: fix building without PCI
Date: Thu, 14 Jun 2007 09:58:51 +0200
References: <20070612163016.253915076@arndb.de>
	<20070612163751.979776796@arndb.de>
	<18032.40314.440212.19149@cargo.ozlabs.ibm.com>
In-Reply-To: <18032.40314.440212.19149@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706140958.52118.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 14 June 2007, Paul Mackerras wrote:
> > Some code looks can be configured to be built without
> > PCI support, but does not work properly.
>=20
> I don't think it makes sense to build a chrp kernel without PCI. =A0I
> would rather just always select PCI for chrp rather than uglifying the
> code with all those ifdefs.

Ok, good. I had done that at first but then saw that the chrp code
already has a conditional on CONFIG_PCI in the Makefile and changed
it.
I have changed it back in my series now.

	Arnd <><
