Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DD27E2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2014 14:24:06 +1100 (EST)
Received: by mail-pd0-f181.google.com with SMTP id p10so3421042pdj.26
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2014 19:24:03 -0800 (PST)
Date: Fri, 17 Jan 2014 11:23:47 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Kernel stack overflows due to  "powerpc: Remove ksp_limit on
 ppc64" with v3.13-rc8 on ppc32 (P2020)
Message-ID: <20140117032347.GB29880@pek-khao-d1.corp.ad.wrs.com>
References: <20140116180532.GA1616@roeck-us.net>
 <20140117022005.GA29880@pek-khao-d1.corp.ad.wrs.com>
 <1389927490.7406.10.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
In-Reply-To: <1389927490.7406.10.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2014 at 01:58:10PM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2014-01-17 at 10:20 +0800, Kevin Hao wrote:
> > On Thu, Jan 16, 2014 at 10:05:32AM -0800, Guenter Roeck wrote:
> > > Hi all,
> > >=20
> > > I am getting kernel stack overflows with v3.13-rc8 on a system with P=
2020 CPU.
> > > The kernel is patched for the target, but I don't think that is relat=
ed.
> > > Stack overflows are in different areas, but always in calls from __do=
_softirq.
> > >=20
> > > Crashes happen reliably either during boot or if I put any kind of lo=
ad
> > > onto the system.
> >=20
> > How about the following fix:
>=20
> Wow. I've been staring at that code for 15mn this morning and didn't
> spot it ! Nice catch :-)
>=20
> Any chance you can send a version of that patch that adds the C
> prototype of the function in a comment right before the assembly ?

Will do. The patch is coming soon.

Thanks,
Kevin

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJS2KJDAAoJEJNY7TDerrFxF3YIAKYibLWpNYAB+RQlqX1wkvjr
3/f/CDELFFZnuwmvbA75HiskEgHkKTr59gv8kNM6dVY63ORCKrFpa7j03rW2hpwX
Q4niqWrQZSZTjeZKndzhZ0mxQka52bL3Eo3xubOH4qFf0udMnGH5L2vIP4cjzcX6
pgDuNc2XdPL03l8g7cPp72F3mwg3+Se6/SAByJRYzUQdtHYbjfvMuL93zpbg4gt3
9aBYuAVVgVrr5e4MIEUWFtt2gAZDUqudAUY5GBLrTBk8MV/W4zTJluQ5FgM/L/cZ
a9wZiNM9PFT/i8QEWYi01iPfEx/0fT0dIxL6i1KaNMZJ6pFvhWPL7QOaHnSsitk=
=VvUL
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
