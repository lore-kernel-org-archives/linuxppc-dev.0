Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1BB2CDDEC8
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 12:23:06 +1100 (EST)
Date: Wed, 20 Dec 2006 12:22:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH]  powerpc iseries link error in allmodconfig
Message-Id: <20061220122249.d0c1f241.sfr@canb.auug.org.au>
In-Reply-To: <1166543839.25827.117.camel@pmac.infradead.org>
References: <20061108173429.GB14991@shell0.pdx.osdl.net>
	<1166543839.25827.117.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__20_Dec_2006_12_22_49_+1100_MiE+9lw1T9TujqJo"
Cc: linuxppc-dev@ozlabs.org, Judith Lebzelter <judith@osdl.org>,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__20_Dec_2006_12_22_49_+1100_MiE+9lw1T9TujqJo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2006 15:57:19 +0000 David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Wed, 2006-11-08 at 09:34 -0800, Judith Lebzelter wrote:
> > Choose rpa_vscsi.c over iseries_vscsi.c when building both
> > pseries and iseries.
>
> Would it not be better to make them both work instead?

The maintainer's take on this is the noone installs onto vscsi disks on
legacy iSeries.

> Untested-but-otherwise-Signed-off-by: David Woodhouse <dwmw2@infradead.org>

And that will, unfortunately, never get into 2.6.20.  I suggest that we
put the simpler patch into 2.6.20 and maybe revisit this afterwards if
we think it is worth the effort.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__20_Dec_2006_12_22_49_+1100_MiE+9lw1T9TujqJo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFiJBuFdBgD/zoJvwRAi12AJ0VkdEN0YmzdGjTxq3g2cIFRu7R4gCeL6HG
Efdbn0yJycHdCE5oI6vY094=
=ulBG
-----END PGP SIGNATURE-----

--Signature=_Wed__20_Dec_2006_12_22_49_+1100_MiE+9lw1T9TujqJo--
