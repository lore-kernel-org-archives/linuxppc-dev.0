Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 1D78DDDE10
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 12:43:31 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Add idle wait support for 44x platforms
Date: Tue, 8 Apr 2008 04:41:28 +0200
References: <7226bef216680748a503.1207262582@thinkpadL>
	<200804080417.37272.arnd@arndb.de>
	<20080407213127.7bb9a769@zod.rchland.ibm.com>
In-Reply-To: <20080407213127.7bb9a769@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804080441.28739.arnd@arndb.de>
Cc: kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 April 2008, Josh Boyer wrote:
> >=20
> > Actually, a static assignment to 0 has not caused the symbol to end up
> > in .data for many gcc versions, it always goes into .bss now unless you
> > assign it a value other than 0 or use explicit section attributes.
>=20
> IIRC, gcc 3.2 is still supported and it didn't do that. =A0Old toolchains
> still exist.

Ok, I thought it was before 3.2. The oldest version I had around was
gcc-3.3 and that had the new behaviour.

	Arnd <><
