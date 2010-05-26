Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/fsl-booke: Move loadcam_entry back to asm code
	to fix SMP ftrace
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1274726319-4673-3-git-send-email-galak@kernel.crashing.org>
References: <1274726319-4673-1-git-send-email-galak@kernel.crashing.org>
	<1274726319-4673-2-git-send-email-galak@kernel.crashing.org>
	<1274726319-4673-3-git-send-email-galak@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-YxwDlMHoXmpXhMyvtDCR"
Date: Thu, 27 May 2010 00:59:30 +1000
Message-ID: <1274885970.21113.6.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-YxwDlMHoXmpXhMyvtDCR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-05-24 at 13:38 -0500, Kumar Gala wrote:
> When we build with ftrace enabled its possible that loadcam_entry would
> have used the stack pointer (even though the code doesn't need it).  We
> call loadcam_entry in __secondary_start before the stack is setup.  To
> ensure that loadcam_entry doesn't use the stack pointer the easiest
> solution is to just have it in asm code.

You could move it to a separate file and have that not built with the
ftrace options (-pg etc.) - but maybe that's not easier.

cheers


--=-YxwDlMHoXmpXhMyvtDCR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkv9N1AACgkQdSjSd0sB4dLg1QCfRqJJUQEc133jmBCgAGzIZmDZ
6dkAniTjLBp8Tj21iSnZ7B4Uc54YF14P
=2YFG
-----END PGP SIGNATURE-----

--=-YxwDlMHoXmpXhMyvtDCR--
