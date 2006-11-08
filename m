Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6E70667CB2
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 11:59:07 +1100 (EST)
Date: Wed, 8 Nov 2006 11:58:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Judith Lebzelter <judith@osdl.org>
Subject: Re: build problems with powerpc allmodconfig
Message-Id: <20061108115858.4171a760.sfr@canb.auug.org.au>
In-Reply-To: <20061107180937.GB1339@shell0.pdx.osdl.net>
References: <20061107180937.GB1339@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__8_Nov_2006_11_58_58_+1100_XEwNbrnxURdIxn+i"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__8_Nov_2006_11_58_58_+1100_XEwNbrnxURdIxn+i
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 7 Nov 2006 10:09:37 -0800 Judith Lebzelter <judith@osdl.org> wrote:
>
> How about just adding an 'ifndef' in the Makefile, as in the patch below?
> This compiles ibmvscsic.o fine.

Looks good.  Please resend with a comment (both for the commit and in the
Makefile) and a Signed-off-by line.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__8_Nov_2006_11_58_58_+1100_XEwNbrnxURdIxn+i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFUSvSFdBgD/zoJvwRAhpRAJ9Nt4iQEw5SEQuYfJrrUCjU+JxeqACfQqrm
T3S8M48uUXtqEUYIPwECfQM=
=lUmH
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Nov_2006_11_58_58_+1100_XEwNbrnxURdIxn+i--
