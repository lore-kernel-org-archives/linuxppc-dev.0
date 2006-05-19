Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14CA2679F5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 22:50:22 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Wolfgang Pfeiffer <roto@gmx.net>
In-Reply-To: <20060518181748.GA2836@localhost>
References: <1147860564.14395.6.camel@johannes>
	<20060517215412.GA4504@localhost> <20060517221945.GA2902@localhost>
	<1147947192.15507.40.camel@johannes> <20060518181748.GA2836@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-uTtiDShrMQxGA/78jRNE"
Date: Fri, 19 May 2006 14:50:18 +0200
Message-Id: <1148043018.3864.6.camel@johannes.berg>
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


--=-uTtiDShrMQxGA/78jRNE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-18 at 20:17 +0200, Wolfgang Pfeiffer wrote:

> BTW: Is there a way to let 'alsaconf' detect the soundcard on this
> PB5,8 ?
> So far that's impossible, as it seems. But this could also be
> related to mistakes I made in my modules files, or wherever.

No idea, but I don't see why you'd want alsaconf to figure it out if the
kernel can by itself...

johannes

--=-uTtiDShrMQxGA/78jRNE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARG2/CKVg1VMiehFYAQKTVw/+Oxd7w+qrBCFmT7XHleEUM4s5rXL1iLiQ
7NFkJOjJBSbVs/OKjS1Cnja5QpBsMD/wc4DBaWaIIAiW0Ipy7ybZ1+esp0wPkFlk
IS22NesovkT+CkxtFif7rL8uhdCQBwIrI5x+1nojRcUr6GIgRlqohJtoOFbwrEkf
LUVysqjMuTwklvy/RkfCU2lxy50iDKwIit/sYqJCJRc3Df098EvzH1gZiF1KFZwy
wh19H+gyUWjDBT0ESmDWSDQAaTT4fTeLnNxUjWZw4EVJ6fWfBhTB4ovKTlOnLQnR
jECX4Ze7NniMA073dCLwJmwOZZF5R28oBZ33CZuw09gxd+EFPKLCWQAp9y0hRRGK
GOQUH78W5JxFV6PGOx3USQmC2BA30vYiikhaGkSt3DCGxYN/WwgZMSL4wxPC+5rs
qXbn5SQYRRvpdGWTASscEbH/hM/BKbkyhxMjFWBM0QF1zICXV8PlF+zHYZvS7p33
VEXFJiWmiwEdkJrQJ2M2k7LX+jlluRFsaXiif1t9VWaJD7m5imtdwjsuRKTwcoo8
cvO3BXBR6ddeYMTBSP7FkJcd4e1pVxduKmhJtjbS/tDofrqXh7LNPIDdK2pW7ZWO
xdZS/MA/G9fdA5uh042I92MMZiCJfUPbOHOtBjU6tDpCy0bWE/VjUIXAr9qP5EJv
fVeukoSR4YE=
=g3FE
-----END PGP SIGNATURE-----

--=-uTtiDShrMQxGA/78jRNE--
