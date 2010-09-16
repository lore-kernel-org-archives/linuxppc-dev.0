Return-Path: <Valdis.Kletnieks@vt.edu>
To: paulmck@linux.vnet.ibm.com
Subject: Re: 2.6.35-stable/ppc64/p7: suspicious rcu_dereference_check() usage
	detected during 2.6.35-stable boot
In-Reply-To: Your message of "Mon, 09 Aug 2010 09:12:00 PDT."
	<20100809161200.GC3026@linux.vnet.ibm.com>
From: Valdis.Kletnieks@vt.edu
References: <1280739132.15317.9.camel@subratamodak.linux.ibm.com>
	<20100809161200.GC3026@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1284649951_6055P";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 16 Sep 2010 11:12:31 -0400
Message-ID: <10430.1284649951@localhost>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>, Li Zefan <lizf@cn.fujitsu.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Subrata Modak <subrata@linux.vnet.ibm.com>,
	DIVYA PRAKASH <dipraksh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--==_Exmh_1284649951_6055P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 09 Aug 2010 09:12:00 PDT, =22Paul E. McKenney=22 said:
> On Mon, Aug 02, 2010 at 02:22:12PM +0530, Subrata Modak wrote:
> > Hi,
> >
> > The following suspicious rcu_dereference_check() usage is detected
> > during 2.6.35-stable boot on my ppc64/p7 machine:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > =5B INFO: suspicious rcu_dereference_check() usage. =5D
> > ---------------------------------------------------
> > kernel/sched.c:616 invoked rcu_dereference_check() without protection=
=21
> > other info that might help us debug this:

> Thank you for locating this one=21  This looks like the same issue that=

> Ilia Mirkin located.  Please see below for my analysis -- no fix yet,
> as I need confirmation from cgroups experts.  I can easily create a
> patch that suppresses the warning, but I don't yet know whether this is=

> the right thing to do.

Ping?  I just hit it on 2.6.36-rc4-mmotm0915.  Just wanted to make sure t=
he
issue hadn't been lost/forgotten.

--==_Exmh_1284649951_6055P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFMkjPfcC3lWbTT17ARAuvZAKCh4ydqf/ApMNSrY0b1/RMlnA6ucQCg6awG
qG+TLw5VQ8RKFcRb7NP0F3A=
=R13/
-----END PGP SIGNATURE-----

--==_Exmh_1284649951_6055P--
