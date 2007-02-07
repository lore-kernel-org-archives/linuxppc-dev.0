Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 3DD63DDDFE
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 11:00:00 +1100 (EST)
Date: Wed, 7 Feb 2007 11:00:22 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Update udbg_progress() to display the integer
Message-Id: <20070207110022.b26c23ea.sfr@canb.auug.org.au>
In-Reply-To: <0C529499-B766-4D3A-8340-361BB1B461D3@kernel.crashing.org>
References: <11707051151024-git-send-email-timur@freescale.com>
	<20070206013051.GA15525@lixom.net> <45C90A6E.3040302@freescale.com>
	<17865.2853.132102.769702@cargo.ozlabs.ibm.com>
	<1170805102.2620.264.camel@localhost.localdomain>
	<0C529499-B766-4D3A-8340-361BB1B461D3@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__7_Feb_2007_11_00_22_+1100_f2SbeBt81hwIjjgJ"
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>,
	Timur Tabi <timur@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__7_Feb_2007_11_00_22_+1100_f2SbeBt81hwIjjgJ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 6 Feb 2007 17:41:24 -0600 Kumar Gala <galak@kernel.crashing.org> wrote:
>
>
> I'm with Ben on this.  I'm not aware of any in tree user that just
> doesn't print this stuff out to a console port.  The concept is nice,
> but does anyone really use it?

Legacy iSeries prints it *and* send it to the HV which displays it as an
SRC value in its various monitoring screen.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__7_Feb_2007_11_00_22_+1100_f2SbeBt81hwIjjgJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFyRaaFdBgD/zoJvwRAksCAJ9wiu8LHVcMfTQwNN9elxb/9OYuVACfYkFM
12mn9OLz67THCbKqzO2Nrdk=
=uZCW
-----END PGP SIGNATURE-----

--Signature=_Wed__7_Feb_2007_11_00_22_+1100_f2SbeBt81hwIjjgJ--
