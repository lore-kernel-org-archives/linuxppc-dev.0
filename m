Return-Path: <compudj@krystal.dyndns.org>
Received: from tomts43-srv.bellnexxia.net (tomts43.bellnexxia.net
	[209.226.175.110]) by ozlabs.org (Postfix) with ESMTP id 42B19DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 11:15:41 +1100 (EST)
Received: from krystal.dyndns.org ([67.68.196.179])
	by tomts43-srv.bellnexxia.net
	(InterMail vM.5.01.06.13 201-253-122-130-113-20050324) with ESMTP id
	<20070206001539.HGOV11361.tomts43-srv.bellnexxia.net@krystal.dyndns.org>
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 19:15:39 -0500
Date: Mon, 5 Feb 2007 19:15:39 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
Subject: Re: [PATCH] powerpc 405 : remove 4xx platform from Makefile
Message-ID: <20070206001539.GC20484@Krystal>
References: <20070205202011.GA13694@Krystal>
	<20070205235426.GA20123@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20070205235426.GA20123@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* David Gibson (david@gibson.dropbear.id.au) wrote:
> On Mon, Feb 05, 2007 at 03:20:11PM -0500, Mathieu Desnoyers wrote:
> > powerpc 405 : remove 4xx platform from Makefile
> >=20
> > Having an empty arch/powerpc/platforms/4xx (no object) causes a linking
> > error. To correct this, 4xx must be removed from the upper level
> > Makefile (just like 8xx).
>=20
> I don't think there's any point to this.  4xx is broken anyway in
> arch/powerpc at present.  When it's fixed (which I'm working on now),
> that directory will no longer be empty.
>=20
> --=20
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson

Ok, I'll stick to arch/ppc for 405 then. Thanks for the info.

Mathieu

--=20
Mathieu Desnoyers
Computer Engineering Graduate Student, =C9cole Polytechnique de Montr=E9al
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
