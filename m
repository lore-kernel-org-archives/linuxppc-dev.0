Return-Path: <nico-linux-ppc@schottelius.org>
Received: from scice.schottelius.org (ns.schottelius.org [213.146.113.242])
	by ozlabs.org (Postfix) with SMTP id D5E5E67A82
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Feb 2005 23:19:07 +1100 (EST)
Date: Fri, 18 Feb 2005 13:20:09 +0100
From: Nico Schottelius <nico-linux-ppc@schottelius.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <20050218122009.GK5801@schottelius.org>
References: <20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<20050127163606.GN14866@Redstar.dorchain.net>
	<20050118094216.GB25470@Redstar.dorchain.net>
	<20050126113554.GD19633@schottelius.org>
	<1106746946.6250.56.camel@gaston>
	<20050208075421.GB21154@schottelius.org>
	<8f293b6dbedd2ae1a825608a48a0604b@kernel.crashing.org>
	<20050218111304.GH5801@schottelius.org>
	<f585c9c6e4bdfbba6dcaafc96b7c0607@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+278g007AL/ykmV8"
In-Reply-To: <f585c9c6e4bdfbba6dcaafc96b7c0607@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Heartbeat LED for iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--+278g007AL/ykmV8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Segher Boessenkool [Fri, Feb 18, 2005 at 01:11:00PM +0100]:
> >>>Btw, howto control it via /dev/adb? Can you point me to a document
> >>>which explains that?
> >>
> >>Write a byte 0x06 followed by the PMU packet (all in one write());
> >>read back the PMU reply (all in one read()).
> >
> >What exactly does 0x06 mean?
>=20
> 6 just means "send to PMU".  It is a Linux thing, nothing to do
> with the PMU itself.

thought something like that.

> >Flash led? Isn't there some kind of
> >"bright-led" "5V,12V,24V" settings available? I mean I want to be able
> >to change the brightness.
>=20
> You can't change brightness on a LED.  You can however make it blink,
> say, a few hundred times per second, and change the duty-cycle.

Ok, that's what I meant.

> >Please point me to a FM about adb.
>=20
> What is a FM?  And it has nothing to do with ADB.

Well, it's the last part of RTFM, so I was asking
for the "fine manual", the documentation to ADB/PMU. So I can
lookup the commands I need for setting the led on/off.

Nico


--+278g007AL/ykmV8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iQIVAwUBQhXdd7OTBMvCUbrlAQLXGQ/+Nu4GFYImtuke5Y9AbFcLg8foLx165a19
n2L+296hYFpOVp2lBIIkpivdU1iItjYsnjZZ9ECFgWHF0PB5MOZ+hIW0UMF11NP4
Bkn0dQlCxj1O1selyWshNdf9h5N2l9AsGsf7KyeFBePEzDZUdnT4GoYakUpV84Xv
IbXKMDzvXL9u68B3nQynot41MLTOc3/yuRqyDmpUM+DMcy3SXd8TuQlEmvrLtAXF
uvNDFY+5ZLDnLZXsY4S8KRMipEO6bRxPq8gV3Mdh6J8sAkyEPcVwheF9vcmTVXC1
gLXKOJR8dI9DT3h6i+Y06nXeg1cPxYf4nUeszpLfwMo0vAQj8tDSAAwNE7SO4NF+
pgydbIPfkV2aqztU9xY8QTh+VzmcLVUvHxxJn9WLiQQFfz1MVkDUchnxlpjcbWQi
Ih44+f5o9yU4t0R9JP1SI7S1e5qd2j2g/maby+LnssMp6jVFk5NQZlvStrtXkawb
X3H0VAYfMM3YyOf/Uq0lrS/qEjG/zC+2hHMD9qJ/0Kmu2/0p2wP245A0+5iIOuhK
XMDuiCioOiwIZWE85MC24zPSt+98DRTNvU9lSo4bD3tkPKTNgPibHi0AUD22aPSv
WOLEpDQdys/Dr8OPpF9xAjErvx0uyhwxU5um/6JSmXp7bkuTdomunKFBGCSl9LFn
DzAzhpEWgAM=
=unpk
-----END PGP SIGNATURE-----

--+278g007AL/ykmV8--
