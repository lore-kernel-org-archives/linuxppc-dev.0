Return-Path: <DaveLiu@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 5C20567A3A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 19:20:44 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k7T9KdRH019994 for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 02:20:39 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7T9KaSi007092
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 04:20:38 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: atomic operations in user space
Date: Tue, 29 Aug 2006 17:20:35 +0800
Message-ID: <995B09A8299C2C44B59866F6391D263511BAE8@zch01exm21.fsl.freescale.net>
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D0FC774@zch01exm20.fsl.freescale.net>
From: "Liu Dave-r63238" <DaveLiu@freescale.com>
To: "Li Yang-r58472" <LeoLi@freescale.com>,
	"Esben Nielsen" <nielsen.esben@gogglemail.com>
Cc: Xupei Liang <tliang@yahoo.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> > 2) These mutexes are based on futexes which requires atomic=20
> > operations in userspace. These are available on most architectures.
Look at
> > the glibc code in
> > nptl/sysdeps/unix/sysv/linux/powerpc/lowlevellock.h for instance.
> > Use that and your PPC manual to implement your atomic operations.
>=20
> No matter semaphore or futex, it uses system calls to kernel.  And the
> true atomic operation is in kernel not user space.  Maybe=20
> it's feasible
> for other architectures to do atomic operations directly in=20
> user space.
> IMHO, not for powerpc.

Are you meaning that we didn't do atomic operations directly in user
space
on powerpc platform ?

-DAve
