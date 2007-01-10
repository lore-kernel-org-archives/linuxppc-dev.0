Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4A40DDDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Jan 2007 16:11:11 +1100 (EST)
Date: Wed, 10 Jan 2007 08:09:49 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/5] [POWERPC] cpm2: Updates for CPM2 pic
Message-ID: <20070110080949.5a0bf1a7@localhost.localdomain>
In-Reply-To: <17828.19395.906600.586578@cargo.ozlabs.ibm.com>
References: <20070110011124.20342.38130.stgit@localhost.localdomain>
	<17828.19395.906600.586578@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_+8loV_rfyKRvHwbA=RbPfjZ";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_+8loV_rfyKRvHwbA=RbPfjZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jan 2007 13:13:23 +1100
Paul Mackerras wrote:

> Vitaly Bordug writes:
> >=20
> > This contains important fixes for the CPM2 PIC code. Eliminated
> > CPM_IRQ_OFFSET, pulling the respective interrupt numbers from the
> > interrupt mapping. Updated devicetree files to reflect that.
> > Changed direct IC-related IO accesses to the IO accessors.
>=20
> I can't put these patches in for 2.6.20 with the titles and
> descriptions you have given.
>=20
well that is to say, mpc8272 is utterly broken without patch 1, as interrup=
t controller will not work at all.
8560's cpm2-related will be hosed too (hence no uart, heh)

> At this stage, for stuff to go into 2.6.20, you need to clearly
> identify what the problem is that you're fixing and give at least some
> indication of why it needs to be fixed for 2.6.20.  If the code
> currently won't compile at all for some config, or is now completely
> wrong because of changes elsewhere, or could cause an oops, then we
> can fix it, but I need something better than just "Updates" in the
> title and a list of what changes you made in the description.  At the
> moment I look at your patch titles and descriptions and think "that's
> nice, but why should it go in 2.6.20?"
>=20

OK. I'll update descriptions and resubmit

> If you're fixing up something that worked in 2.6.19 but now doesn't
> work, that helps justify the change, but you need to say that.
>=20
> These comments apply particularly to patches 1 to 3 in your series.
> For patch 4/5 you at least told us that changes to io.h caused the
> breakage, but even there a bit more detail about what changes caused
> what breakage would be useful.  However, at this stage, you need to
> resist the temptation to do other "overhaul and improvements" while
> you are there; just fix the bugs or breakages that you have identified
> in the description.
>=20
All above is quite right, however  patch 4 does not contain extra code iirc=
 (that do not address breakages),
I just kept same description it used to have at initial revision, submitted=
 during merge window.=20

> Patch 5/5 is OK since it doesn't touch any actual code
>=20
Thanks for looking over this stuff such promptly...

> Paul.

--Sig_+8loV_rfyKRvHwbA=RbPfjZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFpHUeuOg9JvQhSEsRAgHcAJsF4I7ALje+3i5skQv51yqZVVFV3QCfR3vn
W5IqH/f25kkUWhw9Vb1Hx+4=
=77Ms
-----END PGP SIGNATURE-----

--Sig_+8loV_rfyKRvHwbA=RbPfjZ--
