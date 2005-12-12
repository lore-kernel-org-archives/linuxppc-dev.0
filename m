Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (unknown [212.105.56.243])
	by ozlabs.org (Postfix) with ESMTP id 27CF868882
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2005 19:09:35 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 12 Dec 2005 09:09:33 +0100
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D939486EBC@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Paul Mackerras" <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
Subject: RE: Linux process ABI broken in 2.6?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20
>=20
> Joakim Tjernlund writes:
>=20
> > Is it too much trouble to define r7 to always have
> > a zero
> > value at process startup?
>=20
> That's not much trouble, but what will you do for existing kernels?
> Won't you have to do something like testing *r1 anyway?

No, I don't plan to do anything. I just got the first report that static
uClibc apps dosen't work for 2.6, so if the current kernel is fixed I
will just
point to a newer kernel or they can patch their old kernel with the
required 2 line fix.

 Thanks
         Jocke

>=20
> Paul.
>=20
>=20
