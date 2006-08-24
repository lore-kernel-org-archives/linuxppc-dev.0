Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id A491C67C26
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 20:38:50 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k7OBvZCt027938 for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 05:57:35 -0600 (MDT)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k7OAckdv000181
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Aug 2006 05:38:47 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: atomic operations in user space
Date: Thu, 24 Aug 2006 18:39:16 +0800
Message-ID: <4879B0C6C249214CBE7AB04453F84E4D0FC380@zch01exm20.fsl.freescale.net>
In-Reply-To: <82557754AC6C0448A2218FD1C7D50E2AC6FE9F@hq-exch-1.corp.brocade.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Terry Liang" <tliang@Brocade.COM>, <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Why do you need atomic operations in user land?  IPC will be sufficient
to deal with race conditions between processes.=20

Best Regards,
Leo
> -----Original Message-----
> From: linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+leoli=3Dfreescale.com@ozlabs.org] On
Behalf Of
> Terry Liang
> Sent: Thursday, August 24, 2006 3:04 AM
> To: linuxppc-embedded@ozlabs.org
> Subject: atomic operations in user space
>=20
> Thanks. Arnd. My main concern is whether the operations are really
atomic as they
> are in the kernel space. I have read some discussion in another forum
that on other
> platforms, even if you are able to compile the atomic_add(),
atomic_set(), etc.
> from an user space application,  they don't guarantee to be atomic.
Thanks.
>=20
> Regards,
>=20
> Terry Liang
