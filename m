Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 28041DDFE1
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 10:31:21 +1100 (EST)
Subject: Re: [PATCH v2] powerpc: Add irqtrace support for 32-bit powerpc
From: Johannes Berg <johannes@sipsolutions.net>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20080404213932.GA15847@farnsworth.org>
References: <20080404213932.GA15847@farnsworth.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-PxKmZ597Ry4yeEtaVsfc"
Date: Sat, 05 Apr 2008 01:31:09 +0200
Message-Id: <1207351869.6675.0.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-PxKmZ597Ry4yeEtaVsfc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> This version takes care to save and restore *all* the volatile registers
> around the call to trace_hardirqs_off in transfer_to_handler, and should
> fix the anomalies seen by Johannes Berg.  I've tested on 7447- and 8548-
> based boards.

Still has problems on my machine. Maybe to do with non-maskable PMU
interrupts? (saw a patch about something like that float by, don't
really have any idea whether it's related to this work or not)

johannes

--=-PxKmZ597Ry4yeEtaVsfc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR/a6PKVg1VMiehFYAQJRbA//UTCP5k+0ZMQZjlR4IBM4ZuOXBW+YSK55
vmOSXDovdCoxkceG+OD0599swYgnWl3NjdGeWAPQIOGpa78W50Z5OThd16mpWRp6
foHyAmD33ZgAuE3bsJEahTdQJp9uXRY/AzqpNCwGhHpdB1xuXy3umwc9mMsj77u8
NeMRvHpQsvAoRUJKno2oOdLOQzw5mtmN4M6U/bzOyOIiF5X16Cpv+zRmB7yfM62a
AylgaxD+Rv3OL5G8b8kbeBPfLikALbnL0M+gmoPoQL6ZDhaiTeiX4el0GRVxrS+z
zQ7DdQNEimA+e6RLE9KGZ/GUx7fRMm/ZVvSl/IRs8qL8Q2E/xQwt/7A26yKtHOgg
aGfSHuolAcXJFXQpb/IwObGorbwJaRoDEqMA/8lQ9XFPSLXEH+8IYJAzgf4YRLeg
qZ7WO3aN9HwGlgF/Klmnlo8SvKkWDqIbOR2rEkKCmX3L3PTxBZIJAsDhjjTD26jO
HcNDtlbcABRF9/kR20522KRFY9XtrfU0MR/kAWxUJ+ym6T6lZdvNKeeKlIg/B+5Y
b3odQzjcu4eYjjRZuZ0PIQj40JMVh9SIMzD5n8h244t3Gj1mhdBtDTqRYfRaYJCE
0D/ZrYeSR36MTxhNBn9e7ZgdpNS9+eChhZt+RVBRRqif4s636hFXSpg2PH8MyhZl
lSbyuaJdkVo=
=m5vs
-----END PGP SIGNATURE-----

--=-PxKmZ597Ry4yeEtaVsfc--
