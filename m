Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 5AC87679E0
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Dec 2006 21:05:38 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] powerpc: add scanning of ebc bus to of_platform
Date: Mon, 11 Dec 2006 11:01:36 +0100
References: <20061208114113.2191e446@localhost>
	<17788.49546.390921.608302@cargo.ozlabs.ibm.com>
	<1165820168.7260.42.camel@localhost.localdomain>
In-Reply-To: <1165820168.7260.42.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200612111101.37629.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 11 December 2006 07:56, Benjamin Herrenschmidt wrote:
>=20
> > an ack or a nack for the patch? =A0Sounds like a nack to me,
> > but I'm not sure. :)
>=20
> Put it in for now.
>=20

Yes, definitely. I was not objecting to Christian's patch anyway,
but to Ben's idea of getting rid of that part of the code, which
is a side-discussion.

	Arnd <><
