Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D0434DDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 17:17:08 +1100 (EST)
Date: Thu, 20 Mar 2008 17:17:02 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Subject: Re: linux-next: Tree for March 20
Message-Id: <20080320171702.d7fca89b.sfr@canb.auug.org.au>
In-Reply-To: <20080320045719.GA26938@kroah.com>
References: <20080320143953.8d6b5a60.sfr@canb.auug.org.au>
	<20080320045719.GA26938@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__20_Mar_2008_17_17_02_+1100_lmbfYTk/IDvn_Qvf"
Cc: Theodore Tso <tytso@MIT.EDU>, Dan, LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Williams <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__20_Mar_2008_17_17_02_+1100_lmbfYTk/IDvn_Qvf
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Mar 2008 21:57:19 -0700 Greg KH <greg@kroah.com> wrote:
>
> On Thu, Mar 20, 2008 at 02:39:53PM +1100, Stephen Rothwell wrote:
> >=20
> > I have started this tree by reverting the following:
> > driver-core/driver-core-remove-no-longer-used-struct-class_device.patch
> > 	should be merged late
> > driver-core/ib-convert-struct-class_device-to-struct-device.patch
> > 	conflicts with the infiniband tree
> > driver-core/pm-make-wakeup-flags-available-whenever-config_pm-is-set.pa=
tch
> > 	breaks non CONFIG_PM builds of drivers/serial/serial_core.c
>=20
> These should be fixed tomorrow, I have new ones in my inbox to solve
> these issues (I hope...)

Great, I look forward to it.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__20_Mar_2008_17_17_02_+1100_lmbfYTk/IDvn_Qvf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH4gFiTgG2atn1QN8RAgiaAJ9Xr/UfLg4DtHPEFpfHuZ3B5tazsgCgkfCm
P29VJ2vrPMDSqSaJVrC5i8o=
=byML
-----END PGP SIGNATURE-----

--Signature=_Thu__20_Mar_2008_17_17_02_+1100_lmbfYTk/IDvn_Qvf--
