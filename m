Return-Path: <dedekind1@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DAED11007DB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Dec 2011 03:39:15 +1100 (EST)
Received: by iaae16 with SMTP id e16so5054053iaa.38
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Dec 2011 08:39:13 -0800 (PST)
Message-ID: <1324140039.4240.79.camel@sauron.fi.intel.com>
Subject: RE: [PATCH v2] Integrated Flash Controller support
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Li Yang-R58472 <r58472@freescale.com>
Date: Sat, 17 Dec 2011 18:40:39 +0200
In-Reply-To: <94F013E7935FF44C83EBE7784D62AD3F056964B0@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1320053901-23801-1-git-send-email-b35362@freescale.com>
 <CCF7C6DB-437C-4140-894F-2F497AD610DC@kernel.crashing.org>
 <8EDB3DC6-63E5-4D5C-BB52-15F32B85C5DD@kernel.crashing.org>
 <1322602860.2150.10.camel@koala> <4ED5531C.6030104@freescale.com>
 <EFF451D9-552A-4820-90D3-BF3156D5B25F@kernel.crashing.org>
 <1322643080.24797.413.camel@sauron.fi.intel.com>
 <94F013E7935FF44C83EBE7784D62AD3F056964B0@039-SN2MPN1-023.039d.mgd.msft.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-TKiVDr+89xRzipLIeYF+"
Mime-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 Liu Shuo-B35362 <B35362@freescale.com>,
 "linux-kernel@vger.kernel.org Kernel" <linux-kernel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-TKiVDr+89xRzipLIeYF+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-12-14 at 11:13 +0000, Li Yang-R58472 wrote:
> >-----Original Message-----
> >From: Artem Bityutskiy [mailto:dedekind1@gmail.com]
> >Sent: Wednesday, November 30, 2011 4:51 PM
> >To: Kumar Gala
> >Cc: Wood Scott-B07421; Li Yang-R58472; Liu Shuo-B35362; linux-
> >kernel@vger.kernel.org Kernel; linux-mtd@lists.infradead.org; Andrew
> >Morton; David Woodhouse; linuxppc-dev@lists.ozlabs.org list
> >Subject: Re: [PATCH v2] Integrated Flash Controller support
> >
> >On Tue, 2011-11-29 at 19:47 -0600, Kumar Gala wrote:
> >> As Scott said, I was more asking about the 2nd patch in the
> sequence
> >> which did touch MTD.  Since that one is dependent on this patch,
> >> wondering how we wanted to handle them.
> >
> >I do not have time to review it, but it looks OK, so I'd suggest to
> >merge it vie the same tree as the rest of the patches.
>=20
> Hi Artem,
>=20
> So what is your suggestion on this patch?  Can we regard your previous
> email as an ACK and merge it through the powerpc tree?  Or do you
> prefer to merge them through the MTD tree with Kumar's ACK instead?

I am fine if it is merged via PPC tree. I do not have bandwith to look
at it closely, so I cannot ack it, although I also do not have reasons
to nack it :-)

--=20
Best Regards,
Artem Bityutskiy

--=-TKiVDr+89xRzipLIeYF+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO7MYHAAoJECmIfjd9wqK0TVsP/159t9dLDdXVM5hX8sUQhHCS
JN/1GvYyMC0gAvbR/4nPrHViJUv4bFpjlxWH99ktXlyLiPhriMhmkLLW0QFcASzM
O+ZpHTgc8Z9cBa4w5Z9CmRLgZMqIO+6bOWQDCffPSqB7yLoD6Oj7ydRq53yOdKks
098m++7kWsaBPVIrQ90ilFl6hRRkr64CJ8WARTy4IftUWfOX9Q+OaWUHv5UJpLGl
BBioc/CuYgly3uN5gF0/dODrlbEBN6HJ7iLioOssdxBfqCNY6LDF8iPmaxDrqarw
I22IQVFKjogB77YOGrqRfOGmqVJUTXjqhsudo8B+2fN2wSdFsFTcwmqpODTzpJu5
p7VWKje0SnhASmqZOgkYsnUntOCz8KaeEPWrWv1MTaU4ltJr3Ts6magZ653V2tHV
9Mej5HH2FSAQVVgQSjCr/HssJjYkY1m2UDbDihDjvCijeBqA08eCpHml4ctWaxrV
gspck0KN39rLVeusPLQtdYp6QnFSgMRuaaVjkvEnGdooctX80aSReBe14rsX4Mzp
EqEQBP6Y5LbOQJNjkwprLRfVi9ofoVNDkb0VDjC5khqteAzyYcKOCbsuRLfO5CO4
ekoIWG9q7o6UMw0DxvDiL3zTXS/fFGvGfOJTQyutzaHl5zsZF9oMyIfMHcrCfiuv
ePiUYJHy5ovIrRf9g+/9
=FXqb
-----END PGP SIGNATURE-----

--=-TKiVDr+89xRzipLIeYF+--
