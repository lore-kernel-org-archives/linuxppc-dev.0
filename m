Return-Path: <wsa@the-dreams.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DA8A1A0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Dec 2014 03:56:39 +1100 (AEDT)
Date: Mon, 1 Dec 2014 17:56:24 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] i2c: Driver to expose PowerNV platform i2c busses
Message-ID: <20141201165624.GA3212@katana>
References: <20141116171605.4750.17472.stgit@localhost.localdomain>
 <20141125175316.GB9716@katana>
 <1416947765.4998.69.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
In-Reply-To: <1416947765.4998.69.camel@kernel.crashing.org>
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Suuure, let's create more process and committees, and make sure nothing
> gets done in any reasonable amount of time. Have we gone completely
> insane ?

I did not invent DT bindings. I did not invent that DT is/should be a
hardware description. For me, it is a burden that I (as a subsystem
maintainer for mainly drivers) have to prevent people from using DT for
software configuration (some people use it as an 1:1 mapping for
platform data even.) Since there are no guidelines (probably there can't
be), I developed a set of rules out of experience and when those don't
match I ask for help. Having a different set of rules for
powerpc/arm/... (or server/embedded for that matter) will increase this
burden a lot. People will come and say "But they did it as well..."

> It's getting quite tempting to just throw that driver into powerpc.git

Maybe this is the easiest. Just make sure that MAINTAINERS also point
this driver to you or PowerNV maintainers. And no Ack from me, please.
Then, I can always say "I dunno" if people start asking questions.

> > > +	pname =3D of_get_property(pdev->dev.of_node, "ibm,port-name", NULL);
> > > +	if (pname)
> > > +		strlcpy(adapter->name, pname, sizeof(adapter->name));
> > > +	else
> > > +		strlcpy(adapter->name, "opal", sizeof(adapter->name));
> >=20
> > ... because I'd like to get an ack from them because of this binding.
>=20
> And I don't give a flying crap about what random ARM SOC vendor thinks
> of my powerpc FW interface for a powerpc unique FW interface.

But you are not alone here. If you open the box for giving busses a
configurable name, I can see other people (without FW) wanting this,
too. So, this discussion will come anyhow IMO.


--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfJ24AAoJEBQN5MwUoCm2BaMP/2Cim0oOYcjjtEux7GPws+dt
dtBwou9zNwGaA74kjBEurnMn4OREulN8ulkSupaVVnERDwF9uKl6tkfg0gdoBrgp
pm1qMXA7nUxz6EIhBZB9NL/DuNDjHQ5xtlPy/v+BmsXGgzB6b2DTU9bqkkXM6Nbi
9XipScBQ4d+yCw0y4s//cKD81cZZLKWKrvYbUZtz/wZRHifb6VNGHxXBartq402F
AgNg+KQF4lrXk4mg9Qms+pIlYtJCJ1KJ0DEm5zP3mePrlLaLzb569SO5fTFMp73h
3Z0A3Psim0/kF9JDMYZeBsPr4r3Ymp9BJy81HIsbL5Sz3/y5LQuEKAKBHIO0oHkM
/1qjRHqqXiwHUjDwoMnjCpMxEsLnLnj/O5HxcHxAupQFw/Yb24xg5VmpIXySd2Si
pA7ZgBi87gX60y/eBzlhDEZulUCfVOUkU5ux3oFS5aiA14T7HIOyDqOtu2UxaHd+
lUS/r75zVwAOLDeS1+iLAOVMjxEJnZvox0mYIDBlTPO9ViNX6PsjaTOQMQ2nbfrW
Z9BP2NN3QF9qDtG2nxKd37r2Wa+cD6AQUoPJ/MdQLseZxBUSpGAoJ+DCh+c1FW6i
t0ipkEm4WeODoFlwZEvJfxGHQ2UBQBBRUEY+jR6oAASCI7KST6cuO/IYosxbLRmI
uLffdprw6vpPFpdfydyA
=LLFf
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
