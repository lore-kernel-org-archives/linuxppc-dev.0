Return-Path: <jason.mcmullan@timesys.com>
Received: from exchange.timesys.com (mail.timesys.com [65.117.135.102])
	by ozlabs.org (Postfix) with ESMTP id 5AC7567A78
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Mar 2005 00:44:21 +1100 (EST)
From: Jason McMullan <jason.mcmullan@timesys.com>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <9b9c4447ceb975b7b6dd1498ec686e41@freescale.com>
References: <1111523269.2987.58.camel@ad.doubleclick.net>
	<9b9c4447ceb975b7b6dd1498ec686e41@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9mb8yMLqAudEUV/yO23l"
Date: Wed, 23 Mar 2005 08:44:19 -0500
Message-Id: <1111585459.2987.77.camel@ad.doubleclick.net>
Mime-Version: 1.0
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] CPM2 cleanups
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-9mb8yMLqAudEUV/yO23l
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2005-03-22 at 23:53 -0600, Kumar Gala wrote:
> Some additional comments:
>=20
> * Did you actually try setting CPM_IRQ_OFFSET to a non-zero value?  I'm=20
> guessing this doesnt work since you are not offset the irq passed into=20
> the other functions.  For example, if CPM_IRQ_OFFSET is 64, will=20
> cpm2_mask_irq() work?

  YAA! Good catch! (fix fix fix fix....)

> * what is SA_NOTHREAD all about?

  Stale debugging code. Will be removed on the next patch.

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-9mb8yMLqAudEUV/yO23l
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBCQXKz8/0vJ5szK6kRAsiwAJ9DDJAz4pOGO9hRuw74RxCyOyYHBgCgwntR
fdSNTVt/cyO/h4L1bc3/JIQ=
=DxLd
-----END PGP SIGNATURE-----

--=-9mb8yMLqAudEUV/yO23l--
