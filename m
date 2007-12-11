Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id F4212DDEEC
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 04:44:36 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: Patches added to for-2.6.25 and master branches of powerpc.git
Date: Tue, 11 Dec 2007 18:44:12 +0100
References: <18270.8249.393061.840667@cargo.ozlabs.ibm.com>
	<E1J26IB-0004sq-Pt@jdl.com>
In-Reply-To: <E1J26IB-0004sq-Pt@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200712111844.14770.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 11 December 2007, Jon Loeliger wrote:
> So, like, the other day Paul Mackerras mumbled:
> >=20
> > Jon Loeliger (2):
> > =A0 =A0 =A0 [POWERPC] Clean out asm/of_{platform, device}.h
> > =A0 =A0 =A0 [POWERPC] Clean out asm/of_{platform, device}.h from sysdev/
>=20
> Excellent, thanks!
>=20
> That leaves just this following patch from my janitor series.
>=20
> =A0 =A0 http://patchwork.ozlabs.org/linuxppc/patch?id=3D14712
>=20
> I suspect Arnd might need to pick it up or ACK it now?
>=20

Thanks for reminding me. Incidentally, I picked it up today anyway,
but I guess it would be good if Paul took it directly now that
we're on the topic. Otherwise, I'll submit it along with the
others I found in the archives within the next days.

Acked-by: Arnd Bergmann <arnd@arndb.de>
