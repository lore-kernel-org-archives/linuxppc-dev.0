Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33B1967A41
	for <linuxppc-dev@ozlabs.org>; Thu, 25 May 2006 19:43:28 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Eddy =?iso-8859-2?Q?Petri=BAor?= <eddy.petrisor@gmail.com>
In-Reply-To: <60381eeb0605250021t17ff3299l74fc59993c683306@mail.gmail.com>
References: <1147860564.14395.6.camel@johannes>
	<60381eeb0605180025v2495715scb345d7067518ecc@mail.gmail.com>
	<1147947784.15507.46.camel@johannes>
	<87wtcirw0y.fsf@briny.internal.ondioline.org>
	<20060523154137.GA3205@spring.luon.net>
	<60381eeb0605250021t17ff3299l74fc59993c683306@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-dkSA1VzUQuWNBTVvERCh"
Date: Thu, 25 May 2006 11:43:19 +0200
Message-Id: <1148550200.11759.2.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-dkSA1VzUQuWNBTVvERCh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-25 at 10:21 +0300, Eddy Petri=C5=9For wrote:

> Same machine here; I have cloned the aoa repo and "made" it.
> Insmod didn't work on any other module but the the soundbus, and
> resulted in a missing symbol.

You probably forgot to load snd-pcm.

johannes

--=-dkSA1VzUQuWNBTVvERCh
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHV8NaVg1VMiehFYAQLfmRAAwHrC+FplXbnWUOk6GCXLJ1IU4x6t0iUi
eleE5iDdnHlSM7sObFz12yPm05HWXgu3X0ECwvYmvX4QAZTjfBwPOUDZ0oJk47g8
RUJ4fIgN4SQSOwodVG5F+PvmuOKoLcyA8Wd4aAul3op/ViKBcRwuO4ZIDbjezlGI
LmYi/AjttPlhLJzh1WiYMBvST6XHQzimhKTN3abbhLmUquL40Ug7kawta6BsMSYb
8ZoZSbD9hNo9cmWB1ryEaLzrJ1/2QVz+0+BnOGK4/h+2qjNGqMZBrFb5hle9Qoth
0EhXcqtOrAsSo+YuZq8s4mh9M7tnjNiO5urKgeRCmC3EvU1wM0KyjZOVDoWsX0dw
v+C9kgexGi1fTNGwRaYLeQJPztlObjiN5GlAt8oAlD07C5lUIhYvlXmFRegEQSKW
NhCWYRODex1u/U3+hG5jlJ4z554/JWTXkkx1hgwLnQSL1piVsBKttDJHvETUw1z1
VWBeqaFe8j4RFGhAlApMKhKoy7lmIGgMWZDWR7904mSN7CV4xexI+aubjRepnYDG
Nd1vwhaVvIi3X1v0qY5lECOiYsnjB7lGMD+VF4HU+f8nUdICfU3+4YYFBQKfXicD
gMlDCJm1XOEAWmYSgRoXffphn7YAmYpw5dvw0NCDB87dJktEg4fJu1fcLohhrVly
in3AgbfQvfU=
=Ny9o
-----END PGP SIGNATURE-----

--=-dkSA1VzUQuWNBTVvERCh--
