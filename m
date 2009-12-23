Return-Path: <michael@ellerman.id.au>
Subject: Re: [HELP] BAD interrupts
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gopalpet-B05799 <B05799@freescale.com>
In-Reply-To: <9F4C7D19E8361D4C94921B95BE08B81BA09038@zin33exm22.fsl.freescale.net>
References: <9F4C7D19E8361D4C94921B95BE08B81BA09038@zin33exm22.fsl.freescale.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-a8z+M6HPVNTWjxaBHwuz"
Date: Thu, 24 Dec 2009 09:43:50 +1100
Message-ID: <1261608230.3401.16.camel@concordia>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-a8z+M6HPVNTWjxaBHwuz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-12-23 at 19:41 +0530, Kumar Gopalpet-B05799 wrote:
> Hi all,
> =20
> I am trying linux 2.6.32-rc3 in SMP mode. I am seeing a lot of BAD
> interrupts when I do a "cat  /proc/interrupts".
> =20
> I am running a forwarding application b/w two ethernet ports (ethernet
> uses gianfar driver).
> =20
> Has any one observed these BAD interrupts ? If so, can someone help me
> in understanding why these interrupts come and how to resolve it ?

You'll need to tell us what platform you're running on.

The BAD interrupts come from ppc_spurious_interrupts. It's a count of
the number of times we entered do_IRQ() (ie. took an external
interrupt), but when we asked the interrupt controller which irq it was,
the interrupt controller said there was no irq.

Depending on your interrupt controller that might happen sometimes for
valid reasons. Or it might indicate something is setup wrong.

cheers


--=-a8z+M6HPVNTWjxaBHwuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAksynSYACgkQdSjSd0sB4dKiuwCePaMae1nbzLfxaNDVRTNnFSk7
I0EAnAtrFG4So4e/E6t3ZosvkOStvtoB
=d8b5
-----END PGP SIGNATURE-----

--=-a8z+M6HPVNTWjxaBHwuz--
