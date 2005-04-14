Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (sipsolutions.net [66.160.135.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B07B067B5E
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Apr 2005 23:20:44 +1000 (EST)
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1113484515.5516.100.camel@gaston>
References: <1113113792.9517.476.camel@gaston>
	<1113483344.5614.17.camel@localhost> <1113484515.5516.100.camel@gaston>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-6YHZPTnzp1jOMUpuRK/P"
Date: Thu, 14 Apr 2005 15:20:10 +0200
Message-Id: <1113484810.5612.20.camel@localhost>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: [PATCH] pmac: sound support for latest laptops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-6YHZPTnzp1jOMUpuRK/P
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-14 at 23:15 +1000, Benjamin Herrenschmidt wrote:

> I don't know, this is definitely not a problem with the platform
> specific part of the driver, which is what I've been dealin with lately.
> You may find a better answer with the Alsa folks regarding the actual
> PCM implementation.

Ok. In the meantime, a workaround has been committed to the gstreamer
CVS (because, as he put it "but since there's lots of kernel modules and
every new one might have such an issue again i'd like to have a
workaround")

johannes

--=-6YHZPTnzp1jOMUpuRK/P
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQl5uCaVg1VMiehFYAQJNjhAAic3rpxWb1Y4HPUygc1ngPWgZTV22L46Y
M6ut6Okpl8R4JsUQR86DCoqo87JVIVIivRPSH36Q4VJGyHMls3yjWljX5zmd1P44
ps9Pz01Bwiz4r7BoWBwSSHtquNwcRGovLqjbu6Zxpuw9meXDEZtC8ajmf8voYpAC
lwAJlSruZw5TAxYWjo00MGijIq6rWdClLBxdJJUoaN9zMur15nYICeqQfH5mpUzf
cB6jf9m6AB5+DZNEOMM2QPnDlRpHdQW2Lcrl8sQVRjtDOpCkd/cWHbp3pi7pHonx
hMc5KtuFTwaBfhWg4Y7bQMZ82xw8zvjwlu73bh9zJ9TmtwR0UNSdYjhsj8NRKN4a
pVfRn9wueL9zlzPnvrXO+U74byPJM1zaFyEP87QDINa6Yma0XC6KXsy9qdA0Y3Bx
4f3JJ/y1AJVSCbgFp5I0NhrL9jgNJfhtRwKlOrD0M7kO5AZW+lUyV/p2zOdRw9zm
prEgQ44PQGbfGaH9MzXHMYbVD96XgZkXXu+5Rjr1+JW9FngtfMIO0wxhvfcInovu
xE3U39qUlTm6PZr2akUgw/P9s8ErmntMMf5wtVoxHwl3RWHIwHz1tO70EGO0cwzi
2Dsdq9fvud0lP4QN1x/YCYz0S87rRCi7G2OqSlJxh04pWJg6QLulm0pTWw9QOg3M
L9+pz+SJWOk=
=xggD
-----END PGP SIGNATURE-----

--=-6YHZPTnzp1jOMUpuRK/P--
