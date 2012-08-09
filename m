Return-Path: <tony@bakeyournoodle.com>
Date: Thu, 9 Aug 2012 15:57:45 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH V5 2/3] powerpc/swiotlb: Enable at early stage and
 disable if not necessary
Message-ID: <20120809055744.GA13146@thor.bakeyournoodle.com>
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-3-git-send-email-B38951@freescale.com>
 <66F04906-39B4-493D-8C63-202112AB1EA3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
In-Reply-To: <66F04906-39B4-493D-8C63-202112AB1EA3@kernel.crashing.org>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2012 at 02:03:45PM -0500, Kumar Gala wrote:
>=20
> On Aug 3, 2012, at 5:14 AM, Jia Hongtao wrote:
>=20
> > Remove the dependency on PCI initialization for SWIOTLB initialization.
> > So that PCI can be initialized at proper time.
> >=20
> > SWIOTLB is partly determined by PCI inbound/outbound map which is assig=
ned
> > in PCI initialization. But swiotlb_init() should be done at the stage of
> > mem_init() which is much earlier than PCI initialization. So we reserve=
 the
> > memory for SWIOTLB first and free it if not necessary.
> >=20
> > All boards are converted to fit this change.
> >=20
> > Signed-off-by: Jia Hongtao <B38951@freescale.com>
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > arch/powerpc/include/asm/swiotlb.h       |    6 ++++++
> > arch/powerpc/kernel/dma-swiotlb.c        |   20 ++++++++++++++++++++
> > arch/powerpc/mm/mem.c                    |    3 +--
> > arch/powerpc/platforms/44x/currituck.c   |   10 ++--------
> > arch/powerpc/platforms/85xx/mpc85xx_ds.c |    1 +
> > arch/powerpc/platforms/85xx/qemu_e500.c  |    1 +
> > arch/powerpc/sysdev/fsl_pci.c            |    5 +----
> > 7 files changed, 32 insertions(+), 14 deletions(-)
>=20
> Josh, Tony
>=20
> Can you ack the 44x/currituck.c change.

Looks fine to me.

Acked-by: Tony Breeds <tony@bakeyournoodle.com>

Yours Tony

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQI1FYAAoJEEsCiJRY75GKiZYP/1vD52/wqMfM1wEsltUjBU9Q
CYEUTBBwHL7PXJKT3lnyv27DFeAm9ZRZ5ufDNk8k6SCUUwVv6QZ6bUTkSaSUNe/Q
1VWlCKG30aBjv0veZbUdvTSO7XWSWKbNBbAWpmpqIL0+xW6zFUrAlz+esjUY9OtK
0MiXIiFwaFCRP4iyhxsNAHE2GrKfL75CiY61+8vs0icH73vViHSzaGMY9miwdDyx
aTg9V+BF1kwVwUMRS/StGHDGwtmDpeMGO4UhzbOEQKh+goZ4PksKpcrNSjacodS6
hNJheU5R12OryElMg/tnh4f2nGyzjsi7wdr58i7QTVUWECWf4mlHf11ZOKJq0qBP
HuUOPkzOjapBG6fqaHFalTtz81HA2+6pc6Mi0cIS6pUvVq8g2sySsacQJ8GEuOCt
zFO8wlIRVcpbHGDhRcWaHxx1FJm4uD9a7+lpvgN+dABrs1DXTARngwqd58vsIAs/
Ss7ewkRV/7I5+q5U4IeDrMT794oB3UXWb/XPr6tWJnaVrL4vtvk/OtNuM2volOxJ
kXcrpqElWLO+u9R1Gv+h2vogOjZddpdec5pgv1Vhgds7V5HC1LaqqvZPUVBxrGn9
9/W5/Xv12K1GdeFctC6+rWyOtfl9MrZad2ivkV4dNnwE8tKQyHCG2nYC4tMKcHl8
JKS03pHnYwRvIR8/IcxY
=IDFZ
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
