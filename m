Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2A52CDDEA0
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 12:03:32 +1000 (EST)
Date: Tue, 15 May 2007 12:03:21 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/3] Bamboo platform support
Message-Id: <20070515120321.8385a60f.sfr@canb.auug.org.au>
In-Reply-To: <1179191003.3420.78.camel@zod.rchland.ibm.com>
References: <1179154608.3420.21.camel@zod.rchland.ibm.com>
	<1179154743.3420.25.camel@zod.rchland.ibm.com>
	<20070515105837.204d080f.sfr@canb.auug.org.au>
	<1179191003.3420.78.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__15_May_2007_12_03_21_+1000_Yv8EnJGF984dT5G8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__15_May_2007_12_03_21_+1000_Yv8EnJGF984dT5G8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 14 May 2007 20:03:23 -0500 Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:
>
> Wasn't by accident.  I was following the lead of what was done for
> Ebony/440GP (which is actually broken at the moment but has a patch
> pending to comment it out as above).
>
> There is no ethernet period without the new EMAC rewrite and I'd like to
> leave the select there but commented out to serve as a placeholder if
> nothing else.  Of course, if there are lots of objections it can be
> pulled.

Sorry, I misunderstood. That's fine.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__15_May_2007_12_03_21_+1000_Yv8EnJGF984dT5G8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSRTwFdBgD/zoJvwRAt6yAJ9Gl10Tm4kxUiuPf9aE4yeuLqpVFwCcCJx5
utxlwsNNiOvGUhtpFj5Iq+w=
=E1Ux
-----END PGP SIGNATURE-----

--Signature=_Tue__15_May_2007_12_03_21_+1000_Yv8EnJGF984dT5G8--
