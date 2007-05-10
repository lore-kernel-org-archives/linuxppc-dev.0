Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6A631DDED1
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 09:45:40 +1000 (EST)
Date: Fri, 11 May 2007 09:45:30 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: 2.6.21-mm2 -- powerpc missing kset
Message-Id: <20070511094530.59271fdb.sfr@canb.auug.org.au>
In-Reply-To: <20070510084802.04476f66.randy.dunlap@oracle.com>
References: <20070509012322.199f292b.akpm@linux-foundation.org>
	<4643068C.8010302@shadowen.org>
	<20070510221631.5eb38bdd.sfr@canb.auug.org.au>
	<20070510084802.04476f66.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__11_May_2007_09_45_30_+1000_JP.3Gv.TUVkX0Wut"
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Fri__11_May_2007_09_45_30_+1000_JP.3Gv.TUVkX0Wut
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 10 May 2007 08:48:02 -0700 Randy Dunlap <randy.dunlap@oracle.com> wrote:
>
> On Thu, 10 May 2007 22:16:31 +1000 Stephen Rothwell wrote:
>
> > On Thu, 10 May 2007 12:48:28 +0100 Andy Whitcroft <apw@shadowen.org> wrote:
> > >
> > > arch/powerpc/platforms/pseries/power.c:31: warning: `struct subsystem'
> > > declared inside parameter list
> >
> > There is no explicit reference to struct subsystem in the current version
> > of that file.
>
> There is in 2.6.21-mm2.  Are you saying that it's been fixed
> somewhere else?  (where?)

Linus' tree.  It was fixed by commit
823bccfc4002296ba88c3ad0f049e1abd8108d30 ('remove "struct subsystem" as
it is no longer needed') from Greg Kroah-Hartman dated 2007-04-14 which
was applied before v2.6.21-mm2 (according to gitk).

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__11_May_2007_09_45_30_+1000_JP.3Gv.TUVkX0Wut
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQ66iFdBgD/zoJvwRAioKAJ9EQnHa2KDcz7UfCkgDVpuXOZqcGwCeKuD3
FF+KQ38cc485Ay1q+ubiEQ4=
=QxJn
-----END PGP SIGNATURE-----

--Signature=_Fri__11_May_2007_09_45_30_+1000_JP.3Gv.TUVkX0Wut--
