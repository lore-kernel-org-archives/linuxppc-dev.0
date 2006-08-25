Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 396A167C33
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 12:33:03 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k7P2X1Yv011080 for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 19:33:01 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7P2Ww0Z014913
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 21:33:00 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: atomic operations in user space
Date: Fri, 25 Aug 2006 10:33:28 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC41E@zch01exm20.fsl.freescale.net>
In-Reply-To: <200608240918.19450.bcook@bpointsys.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Brent Cook" <bcook@bpointsys.com>, <linuxppc-embedded@ozlabs.org>
Cc: Terry Liang <tliang@brocade.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Brent Cook [mailto:bcook@bpointsys.com]
> Sent: Thursday, August 24, 2006 10:18 PM
> To: linuxppc-embedded@ozlabs.org
> Cc: Li Yang-r58472; Terry Liang
> Subject: Re: atomic operations in user space
>=20
> On Thursday 24 August 2006 05:39, Li Yang-r58472 wrote:
>=20
> > Why do you need atomic operations in user land? IPC will be
sufficient
>=20
> > to deal with race conditions between processes.
>=20
> >
>=20
> > Best Regards,
>=20
> > Leo
>=20
> What about multiple threads within a process updating a counter?

Is there anything preventing semaphore to be used in threads?
>=20
> Of course, if you look at these functions in the kernel header,
they're just 2 or
> 3 inline assembly calls - you could easily rewrite them. Google for
'PowerPC atomic
> increment' and grab one of the unencumbered implementations if you
need to use it
> in a non-GPL program.
>=20
> On the other hand, I see no license at the top of my
/usr/include/asm-i386/atomic.h
> file at all, same for PowerPC - are Linux header files actually GPL or
are they
> more like the glibc headers, with exceptions made for userspace
programs?
>=20
> The atomic operations on x86 were accidentally exported early on, so
they have to
> hang around apparently for compatibility (there are some mailing list
threads out
> there to this effect.) Currently, you just have to assume in Linux
that if you
> include something from /usr/include/linux or asm that it will not
necessarily be
> cross-version or cross-architecture compatible. Not every arch in
Linux even has
> atomic operations of this nature, which I guess is the main reason why
they are
> not exported in general.
>=20
> - Brent
