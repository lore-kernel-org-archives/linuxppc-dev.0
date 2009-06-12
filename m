Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 47DA8B71F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 18:36:04 +1000 (EST)
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 37B69DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 18:36:04 +1000 (EST)
Date: Fri, 12 Jun 2009 18:35:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [Powerpc/SLQB] Next June 06 : BUG during scsi initialization
Message-Id: <20090612183559.33018f0c.sfr@canb.auug.org.au>
In-Reply-To: <1244795139.30512.23.camel@penberg-laptop>
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com> <4A2909E8.6000507@in.ibm.com>
	<Pine.LNX.4.64.0906071105030.11309@melkki.cs.Helsinki.FI>
	<4A2D001E.5060802@in.ibm.com>
	<20090609141903.GE15219@wotan.suse.de>
	<4A31EB2A.9080003@in.ibm.com>
	<20090612074213.GA21070@wotan.suse.de>
	<4A320D12.2050802@in.ibm.com>
	<20090612082145.GD24044@wotan.suse.de>
	<1244795139.30512.23.camel@penberg-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Fri__12_Jun_2009_18_35_59_+1000_r1CRJiogEE36eWH6"
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__12_Jun_2009_18_35_59_+1000_r1CRJiogEE36eWH6
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On Fri, 12 Jun 2009 11:25:39 +0300 Pekka Enberg <penberg@cs.helsinki.fi> wr=
ote:
>
> Hmm, SLQB in my for-next branch. Stephen, is slab.git dropped from
> linux-next or something?

Yesterday (next-20090611) the slab tree for linux-next had only one
commit in it ("SLUB: Out-of-memory diagnostics").  Today (next-20090612)
it has quite a lot in it again - including SLQB.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__12_Jun_2009_18_35_59_+1000_r1CRJiogEE36eWH6
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoyE28ACgkQjjKRsyhoI8yu9QCeLXG1xaJg5/rRT32MW1R8p6B1
NJsAn0/Nf8k5NY1Ybv/MVnhbw6AqpdTU
=/kg4
-----END PGP SIGNATURE-----

--Signature=_Fri__12_Jun_2009_18_35_59_+1000_r1CRJiogEE36eWH6--
