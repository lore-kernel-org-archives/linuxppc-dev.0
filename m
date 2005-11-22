Return-Path: <Simon.Richter@hogyros.de>
Message-ID: <438338B3.5000301@hogyros.de>
Date: Tue, 22 Nov 2005 16:26:43 +0100
From: Simon Richter <Simon.Richter@hogyros.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1132645967.26560.221.camel@gaston>
In-Reply-To: <1132645967.26560.221.camel@gaston>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3EB5A278807336E3E94D5459"
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: powerpc  boot sequence rework
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3EB5A278807336E3E94D5459
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Benjamin Herrenschmidt wrote:

> Here's a quick review of what happens now before my intended changes and
> some hilights of the ppc32/ppc64 differences. I intentionally ignored
> APUS as I don't even pretend to understand what it does, it will have to
> adapt to our changes anyway :)

Heh. I was anticipating this since the Oldenburg meeting.

>  - Very early trampoline code from the firmware (prom_init/bootx_init)
> that could eventually be moved to a boot wrapper but is currently kept
> in the kernel for convenience.

That answers my question whether I should have the code that builds the 
flattened device tree in the kernel or in the bootloader.

    Simon

--------------enig3EB5A278807336E3E94D5459
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ4M4xFYr4CN7gCINAQJzZwP/TNkjZv4bBrDVHU0D9SH5ghD6osYwsCrT
xEicCddqfvvejyPHGCMtKqTsnRn43jJDG9NugAk1DcGCZyqyVmhmHUPktwWmG7km
+2ILXuygzUVEJLcVfyCV32HMgr3LlMmO8bqhdi46ei1AQdJypoDiPXhVCfZjvgpC
l6u1gc8S5wA=
=Ljq2
-----END PGP SIGNATURE-----

--------------enig3EB5A278807336E3E94D5459--
