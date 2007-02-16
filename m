Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id E6660DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Feb 2007 07:56:02 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: What happened to include/asm-ppc??
Date: Fri, 16 Feb 2007 21:50:44 +0100
References: <32201137.34111171657512254.JavaMail.root@vms061.mailsrvcs.net>
	<E6C97B4B-F3DF-4AEC-A225-60DC6AE05691@freescale.com>
In-Reply-To: <E6C97B4B-F3DF-4AEC-A225-60DC6AE05691@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702162150.44997.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 16 February 2007 21:45, Andy Fleming wrote:
>=20
> They're probably in include/asm-powerpc/
>=20
> You'll need both, since there are still some files in asm-ppc that =A0
> are needed by the asm-powerpc stuff.

That shouldn't be the case, the headers from asm-powerpc should be
sufficient for all 32 and 64 bit user apps, if not then you should
really report that as a bug.

	Arnd <><
