Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 501E4DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 08:37:35 +1100 (EST)
Subject: Re: relocatable kernel vs. yaboot
From: Johannes Berg <johannes@sipsolutions.net>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18698.10295.463071.212141@cargo.ozlabs.ibm.com>
References: <1225322811.5280.5.camel@johannes.berg>
	<18698.10295.463071.212141@cargo.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-rUpnH+PSYsqZT254F9VO"
Date: Thu, 30 Oct 2008 22:37:14 +0100
Message-Id: <1225402634.16440.2.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-rUpnH+PSYsqZT254F9VO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-10-31 at 08:33 +1100, Paul Mackerras wrote:

> Yes, yaboot needs to be fixed.

Yeah, my bad, I was offline when writing this and only checked later to
find you'd already discussed that. Sorry.

> > Modifying the vmlinux in the same way as above makes yaboot take it, an=
d
> > I can easily make this part of my installation procedure, but I wonder
> > if it should be done automatically? Or maybe only documented in the
> > Kconfig help text? I probably wouldn't have enabled it and then wondere=
d
> > why it doesn't work if it had warned me about breaking yaboot ;)
>=20
> Yes, we could add something to the help text.  Until yaboot gets
> fixed, you could either boot the zImage with yaboot or use that
> iseries hack.

I can send a patch if you want?

> Why did you enable it?  Just to try it out?  The main reason for
> having it turned on is if you want to have a single kernel image that
> can be used both as a normal kernel and a kdump kernel.

Yeah, no particular reason, just enabled it on a whim when oldconfig
asked.

johannes

--=-rUpnH+PSYsqZT254F9VO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJCikEAAoJEKVg1VMiehFYjegP/Rru9uq1WOxZ0JgLaDzAMWTe
DDMYqxN+8b37uc7CDlp7cyJovnHbLGtbg1AU98kVy2LP0xUMQgt/Y7apP/JeWSgo
u+sAh6g8SfJm22405NY3H1nD5HXcL4GVSlsgoeh2luQ/rN4bLxeYonMxSiyyPWTe
68W5A0OeH0AtuvMrIT39R7XyHLmcTfZKjVyUd7lDZaTMGPahiTQwGtkhZDUpyOoL
LcHkNH6T1NJEWgwmN/CgqJ+Ady0HxrXxItiINnsWfd6qc5s6tDZD53KTTLjt0zk8
Spwt5yw81SgDFi5ByvWR7cJk4Go2lvuC7gVoEATkBg05UBk0lTwkrcTyjFf1h3F5
tKtibn3HNKmYS+jBLotmqEh9yZs0Zm2lp4amiH2SxrM7wqSKMyNguzL+iQVvrZwR
kEnP40DCCEJ6miJqjx55ScjFknMQCGle5TzDJm7x3z6DxlYnwlbpeslIsTNL62yf
Qer8/LrnhTWET7WaiZv66XEYuMa9J8L13vo3i15ynRNYZ2C57ew4RPZ3ZRTFlGVX
vC/SUkFR9Q9Ar1ZNBGI5KdYpDdliJeKxkEqsSfSMFbwOoxTm8DkEK04aE7O/lC6Z
XKvEZ2Bgn2Ea9Ny/uHx/gLRjTbG3YG9mlsNQMh8hf9tzzRkqk/8F9HHMrV9OQ1bg
erzQYhrsyP0/petEmtds
=7JJf
-----END PGP SIGNATURE-----

--=-rUpnH+PSYsqZT254F9VO--
