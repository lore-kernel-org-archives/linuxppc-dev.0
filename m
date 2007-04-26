Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 036EADDEC4
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 11:34:38 +1000 (EST)
Date: Thu, 26 Apr 2007 11:34:56 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Loeliger Jon-LOELIGER" <jdl@freescale.com>
Subject: Re: [PATCH 4/6] Consolidate of_get_parent
Message-Id: <20070426113456.e4509cb2.sfr@canb.auug.org.au>
In-Reply-To: <AF0367BA48C55940A43CCF08DF35553C011ECCC9@az33exm24.fsl.freescale.net>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<20070424223245.78f4fdfb.sfr@canb.auug.org.au>
	<20070424224040.6f0fe143.sfr@canb.auug.org.au>
	<AF0367BA48C55940A43CCF08DF35553C011ECCC9@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__26_Apr_2007_11_34_56_+1000_C4BdAiBQpH48jOFy"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__26_Apr_2007_11_34_56_+1000_C4BdAiBQpH48jOFy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 24 Apr 2007 07:42:56 -0700 "Loeliger Jon-LOELIGER" <jdl@freescale.com> wrote:
>
> > sparc64.  It also adds a readlocal around the parent accesses.
> >
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
> Perhaps a read lock?

Yeah, just a small typo :-)

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__26_Apr_2007_11_34_56_+1000_C4BdAiBQpH48jOFy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGMAHHFdBgD/zoJvwRAmZqAJ49y870/TZGcd0nmg3Xw9RrFTqOCgCeMNb3
eZithxrrHHNEY/S7lOrX48w=
=Sykb
-----END PGP SIGNATURE-----

--Signature=_Thu__26_Apr_2007_11_34_56_+1000_C4BdAiBQpH48jOFy--
