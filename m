Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 335B4B6F15
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  5 Jul 2010 08:26:17 +1000 (EST)
Date: Mon, 5 Jul 2010 08:26:10 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Anthony G. Basile" <blueness@gentoo.org>
Subject: Re: Regarding the issue of compiling >=2.6.31 on ppc with >=gcc-4.4
Message-Id: <20100705082610.6221c57c.sfr@canb.auug.org.au>
In-Reply-To: <4C31046C.9060406@gentoo.org>
References: <4C31046C.9060406@gentoo.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Mon__5_Jul_2010_08_26_10_+1000_wkcAl9wEW.9P6ak8"
Cc: linuxppc-dev@lists.ozlabs.org, cjg@cruxppc.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__5_Jul_2010_08_26_10_+1000_wkcAl9wEW.9P6ak8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Anthony,

On Sun, 04 Jul 2010 18:00:12 -0400 "Anthony G. Basile" <blueness@gentoo.org=
> wrote:
>
> Hi guys, I just hit this in trying to stabilize some kernels on gentoo
> - -> http://bugs.gentoo.org/show_bug.cgi?id=3D326877.  Has there been any
> upstream discussion about this?  I haven't seen anything on lkml.  I
> thought I'd drop you a note and see if you guys had heard anything.

You should really ask questions like this on the
linuxppc-dev@lists.ozlabs.org mailing list (cc'd).

[For others: this is the 1024 byte buffer in the stack in
chrp_event_scan()]

Having said that: yes, the problem has been noticed, but no solution has
been included yet (as far as I know).  There are other issues with
building 64 bit PowerPC kernels with gcc >=3D 4.5 for which I have proposed
a couple of patches.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__5_Jul_2010_08_26_10_+1000_wkcAl9wEW.9P6ak8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJMMQqCAAoJEDMEi1NhKgbsviYH/1godRjcw6NgFuMaD/QtSrP+
fkNRHHbtw7yghoHVNv6A206gI79OQRw3ji9CvMnGZ7ykZmx9CzMznTU9/0OyI8P9
Za4ygKawKeljOlVBv2b9/dW91QfQ3XyD3iFVm1vK98/lMxOo8ZfnPSQlHXcaMeiW
xYvWeIXCtsT7+rqdHjLdkV3Tg9S29gXrhRmvGm8mfnBFXqjqE9BViA4H7xZDJW+s
ed9Kqv8Kl6QbKw+VbBsCSbmsE/ub2oOW6qwX0ycVqQ3MplLKwhprR2hmYE0oljA5
QbFVjP9h08ILPXvFUsjsaOQhNRKKa/WX17A0UGCNuwfDbCfRkoejczOfR5uHBHw=
=Q+x0
-----END PGP SIGNATURE-----

--Signature=_Mon__5_Jul_2010_08_26_10_+1000_wkcAl9wEW.9P6ak8--
