Return-Path: <sfr@canb.auug.org.au>
Date: Mon, 12 May 2014 08:23:36 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: linux-next: add scottwood/linux.git
Message-ID: <20140512082336.501fa8a2@canb.auug.org.au>
In-Reply-To: <1399670133.15726.440.camel@snotra.buserror.net>
References: <20140320042527.GA23206@home.buserror.net>
 <1395616617.3460.109.camel@pasglop>
 <1395617608.3460.113.camel@pasglop>
 <1395709794.12479.411.camel@snotra.buserror.net>
 <1399670133.15726.440.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/a45ejLIsKa/qDmEnMXuEy/8"; protocol="application/pgp-signature"
Cc: linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/a45ejLIsKa/qDmEnMXuEy/8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Scott,

On Fri, 9 May 2014 16:15:33 -0500 Scott Wood <scottwood@freescale.com> wrot=
e:
>
> On Mon, 2014-03-24 at 20:09 -0500, Scott Wood wrote:
> > On Mon, 2014-03-24 at 10:33 +1100, Benjamin Herrenschmidt wrote:
> > > On Mon, 2014-03-24 at 10:16 +1100, Benjamin Herrenschmidt wrote:
> > > > On Wed, 2014-03-19 at 23:25 -0500, Scott Wood wrote:
> > > > > The following changes since commit c7e64b9ce04aa2e3fad7396d92b5cb=
92056d16ac:
> > > > >=20
> > > > >   powerpc/powernv Platform dump interface (2014-03-07 16:19:10 +1=
100)
> > > > >=20
> > > > > are available in the git repository at:
> > > > >=20
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.g=
it next
> > > > >=20
> > > > > for you to fetch changes up to 48b16180d0d91324e5d2423c6d53d97bbe=
3dcc14:
> > > > >=20
> > > > >   fsl/pci: The new pci suspend/resume implementation (2014-03-19 =
22:37:44 -0500)
> > > >=20
> > > > Stephen just informed me that your tree wasn't in -next ... Kumar's
> > > > still is.
> > > >=20
> > > > Can you guys fix that up ? I somewhat rely on the FSL stuff to simm=
er
> > > > in -next on its own.
> >=20
> > Stephen, what's the process for adding a tree?
>=20
> ping

Sorry, for the delay.

Just send me a git URL for your tree, and a list of the people I should
contact in case of conflicts/build/fetch problems and cc the
appropriate people/lists.

I also assume that this will actually replace Kumar's tree?
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/a45ejLIsKa/qDmEnMXuEy/8
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTb/htAAoJEMDTa8Ir7ZwVMxwP/2QX1/RPmhwiZuNJkGYx1VEg
3w+g6qrxc/PROspFszXn2/NIw912/xqcfG2hpVFKGRiJ80BRGXYbb6ucEHFn3e1T
0iRdR9ioB8EDPJStDbilTw+jC3/VMUgoV5CMtz159ShxqhES5mg+pQk+rSIFuq4L
k0sefbaCLVuZzZdSkh65ZQmGZgSxr90mMj48yIC5g7eDVWl1vkXXuI3thhkXWhci
4Za5hR9H7iUWY3Mv9+7ZqjH6sbsztIfJBqM3L82QxQYEMMnnyrU/JjMCo0/w9+C/
wklWunUhumDkCw3MoEnebrd2rz+wwJhH/II28R+AHM5eHptIPiwjnsMbr0C/xFFz
XI8l39w9t0CWSy1lxlgeYFudweE3w6UevexL2o0QW0XSqt2HCqRSR2CI3lJdkusb
U+TFdRX27reMHyfP5Ydsj/XoNgCm+42pL+pPqYsJbAl74aqcy/lDJsJEDcZ31Zf/
6CXTa9X09W8mEvpwhlGs/6r8liuG1c1hvPXU3I5ClpZTLmIn1yfrBr4GjxjAvrL2
n5bPhQo2A0jjKBQZyl8iPLdj/KkfTfXcdVMGl/5SsLpAwgVwJjnra6xOhHcOhofC
tH2k75ZOIskCPABIHO7Le3lpEHdotyzF+NfGDyuyZBfLpn27kYTaK/oTac+nYRm5
3CtwtydjN3u9G98rm4sp
=VkPP
-----END PGP SIGNATURE-----

--Sig_/a45ejLIsKa/qDmEnMXuEy/8--
