Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 612AA67D05
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 17:18:54 +1000 (EST)
Subject: Re: Is get_property() correct?
From: Johannes Berg <johannes@sipsolutions.net>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <528646bc0610272341s3c655ebbn785b373f148f6174@mail.gmail.com>
References: <528646bc0610272341s3c655ebbn785b373f148f6174@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/7hYtugSK/shb1k2rgUx"
Date: Sat, 28 Oct 2006 09:17:35 +0200
Message-Id: <1162019855.14051.15.camel@johannes.berg>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/7hYtugSK/shb1k2rgUx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> The comment says it
> returns the value of a property

>  * and return the value.

>         return pp ? pp->value : NULL;

...? Looks like the value to me, unless the property doesn't exist.

johannes

--=-/7hYtugSK/shb1k2rgUx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARUMEDqVg1VMiehFYAQKR1g//XRNsqjZ9yMFyu57II6PEeqbb23v6OUTG
yaED8lup/x/8/b0OlSYBSm0zxuIOTpeXgfDrwD0W7iII/f6m1lKxHR3mUVZcMwqS
9ye3ybiyxqgesEWFfYkz4TeIZDtZgST46s5CUF+GtdxwYv915EtbQef7jk1dPTZ4
X60p3iH5lt4M7iRMEFq8acsG7yY1gY+T7+/qQcMsUpYakDzQFazddigHk5AZrlaj
Y/GRgGOjNMCfO5KBt1jST89OwDNHk73346a+JC7H8LnxgVOqv5qxVzISw1p9NI1h
4jjgTxj62gCFmoaLcIWZ0ojE1rVz96UV8jlbu1TPKvvlFbw9GRQOZRZM6MNJpdiy
lZic8HzqiLCjCgWLKX6ZtILTxytCt3vppB66cfsgc8F24tOIPvKGTFz+zK1eHLuC
hl7J37Oy/KVG5Cw0SH/8mpSi7bWfGffaY184Y0/fsHsMmUYRkXIjgLQc1waOhnOV
SmGAz2CAXSNVAdzSHri69nuVymt9EbV5NjprubJUJDSfWQiZwTB2oc/afZ+x9w1S
baeP46dOKVR+c/IvZ0301xXTwo8kehMCPnqnnoWeqJcElGGjOZTZmRfrLGC/5p7+
5sYDElhiLJW5jmXuoCNt+9RbtR+Gx9YqyQ7foEHwM1HOA2UXCQfepJkOUnR6A9ZP
//PZK9srkmQ=
=10JN
-----END PGP SIGNATURE-----

--=-/7hYtugSK/shb1k2rgUx--
