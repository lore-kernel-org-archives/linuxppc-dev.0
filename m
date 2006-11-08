Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 8 Nov 2006 17:28:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [Cbe-oss-dev] [PATCH] cell: abstract spu management routines
Message-Id: <20061108172830.d1762199.sfr@canb.auug.org.au>
In-Reply-To: <45517325.3090808@am.sony.com>
References: <455161D2.3090004@am.sony.com>
	<1162962074.20271.16.camel@localhost.localdomain>
	<45516A0C.5050607@am.sony.com>
	<1162965270.20271.22.camel@localhost.localdomain>
	<45517325.3090808@am.sony.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__8_Nov_2006_17_28_30_+1100_aNDN6+1bR8BIw.yQ"
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__8_Nov_2006_17_28_30_+1100_aNDN6+1bR8BIw.yQ
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 07 Nov 2006 22:03:17 -0800 Geoff Levand <geoffrey.levand@am.sony.com> wrote:
>
> Michael Ellerman wrote:
> > On Tue, 2006-11-07 at 21:24 -0800, Geoff Levand wrote:
> >> Michael Ellerman wrote:
> >> >> +static struct platform_data *platform_data(struct spu *spu)
> >> >> +{
> >> >> +	BUG_ON(!spu->platform_data);
> >> >> +	return (struct platform_data*)spu->platform_data;
                       ^^^^^^^^^^^^^^^^^^^^^^^
Since platform_data is a void *, you don't need (or want) this explicit cast.

--
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__8_Nov_2006_17_28_30_+1100_aNDN6+1bR8BIw.yQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFUXkOFdBgD/zoJvwRAk4iAKCRF9jhn8trEemx8esOptxbH0riSwCdG9RG
pWWp+xfZapnEmqiQ7piT5aM=
=D7gV
-----END PGP SIGNATURE-----

--Signature=_Wed__8_Nov_2006_17_28_30_+1100_aNDN6+1bR8BIw.yQ--
