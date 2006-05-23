Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 00CFA67B33
	for <linuxppc-dev@ozlabs.org>; Tue, 23 May 2006 22:33:43 +1000 (EST)
Subject: Re: net/ieee80211/softmac/ieee80211softmac_io.c:464: warning:
	'ieee80211softmac_send_ctl_frame' defined but not used
From: Johannes Berg <johannes@sipsolutions.net>
To: Toralf =?ISO-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
In-Reply-To: <200605221948.09538.toralf.foerster@gmx.de>
References: <200605221948.09538.toralf.foerster@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-sFpuwZSpdqgJ1TXy9yd5"
Date: Tue, 23 May 2006 14:33:36 +0200
Message-Id: <1148387617.25971.10.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-sFpuwZSpdqgJ1TXy9yd5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-22 at 19:48 +0200, Toralf F=C3=B6rster wrote:
> While playing with various kernel config I observed the warning above=20
> compiling 2.6.17-rc4-git10.

Yeah, known 'bug', we have that code there but never use it. Feel free
to submit a patch (to John Linville, CC netdev and softmac-dev) to
remove it.

johannes

--=-sFpuwZSpdqgJ1TXy9yd5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHMBH6Vg1VMiehFYAQIkqA/+PzPLBbz8grjSNAGDj59ULrkaQ5WUVp14
KXulD14EonQC4Nqb1pea8jH2b1G33GlpPsqGss6g2DaryC3g0seVW9cfUg9tomI1
XPDTsbirfd/tyyODpCS+hA2Cjkdy6lbvrYFd26zt7zWKsPZxKRvqfb7BvEy0dyBp
0aADkWETkEeKOcngSXgkOF+gehZCyI1znIp49bfmjxVeANj0tOiOORqPr9P8bx18
geNwM+KWDwGJELZ31rn/5mIj/Ce8Lwc3yYhtu+5nb+S46SLCirH20qcLbuWP3sBG
BFSekolAEXKD4uobs6urUWKMLI05IMqRUefuqaZDpfbfT9DhB9hXobGSibNwD66+
AsS/0WLIADtDozMIvz1BO/3rR7kyDh5Bf/7xAQKAJL1AbGN9HpGv7mi4Rffy5F7K
XosLhTf5JkAEF1UmyO3H2BD9NotjvsVD8zWXS29fyJ7SYCFOPEoltTLhPngDRefk
SRyI1mHeYX+N1ttzdujGVmF04PnMv4L1Zqq35XjdjZSEPE3MqTsurA4fEQww72ks
cSe0XrC0I62yksCekNAOB8I6RuaAv4J0mIVK9et/yTZYJjO3K8eoruObB5jfNOM+
GZ/+uJ05JEKMOooPBUrZOamjV5PIp9uPALzMYfHS1GdB/7l1Zqr42PU8OhR+kCJL
cu6boi8wVYE=
=zHgZ
-----END PGP SIGNATURE-----

--=-sFpuwZSpdqgJ1TXy9yd5--
