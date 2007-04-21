Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id F3245DDE3D
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 22 Apr 2007 01:38:29 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org,
 bwarren@qstreams.com
Subject: Re: POSIX semaphores on ppc_6xx
Date: Sat, 21 Apr 2007 17:33:12 +0200
References: <1177091726.3904.21.camel@saruman.qstreams.net>
In-Reply-To: <1177091726.3904.21.camel@saruman.qstreams.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704211733.13354.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 20 April 2007, Ben Warren wrote:
> The cross-compiled glibc that is included in ELDK 4.0 doesn't seem to
> have support for POSIX semaphores. =A0I get the following runtime errors:
>=20
> =A0 =A0sem_open: Function not implemented
>=20
> when trying to implement a named semaphore, and=20
>=20
> =A0 =A0sem_init: Function not implemented
>=20
> when trying to implement an unnamed semaphore.
>=20
> Does anybody know if POSIX semaphores have been ported to ppc_6xx, and
> if so, where I could find a binary copy?

This normally works in every modern glibc. Maybe you were using an
set of kernel headers that is too old. Make sure that you have
up-to-date version of both kernel and glibc and that you use the
kernel header files you get from 'make headers_install' in the kernel.

	Arnd <><
