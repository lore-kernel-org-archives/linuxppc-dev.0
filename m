Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F45B679EF
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 22:21:42 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC] alsa integer control ranges
From: Johannes Berg <johannes@sipsolutions.net>
To: Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <Pine.LNX.4.61.0605170836470.10248@tm8103.perex-int.cz>
References: <1147780945.29795.110.camel@johannes>
	<Pine.LNX.4.61.0605161430220.9330@tm8103.perex-int.cz>
	<1147817058.6753.7.camel@localhost.localdomain>
	<Pine.LNX.4.61.0605170836470.10248@tm8103.perex-int.cz>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-G4lvbkVisl3hvEGj4mrA"
Date: Wed, 17 May 2006 14:21:10 +0200
Message-Id: <1147868470.15507.9.camel@johannes>
Mime-Version: 1.0
Cc: ALSA development <alsa-devel@alsa-project.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-G4lvbkVisl3hvEGj4mrA
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 08:41 +0200, Jaroslav Kysela wrote:

> It's better to have problematic values by default and define a module=20
> (driver) option to enable the "compatible" behaviour.=20

I just committed the patch to be always compatible. I'm not going to
clutter the code even more.

> Otherwise the apps=20
> will be never fixed.=20

True.

> Also, ideally, you can fix apps and send patches to=20
> authors and/or create problematic controls in the dummy driver=20
> (drivers/dummy.c) and send a notice to app developers that they have=20
> broken apps and ask to fix them refering to the dummy driver test case.=20

The dummy driver isn't a bad idea, all the rest is. There are *dozens*
of broken apps, and most of their code is horrid. I couldn't even fix
alsamixer for the 3..28 range brokenness.

johannes

--=-G4lvbkVisl3hvEGj4mrA
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGsVNKVg1VMiehFYAQKldxAAug4lXUqIcAbOxDkxZTKj8fv72hi73Lnl
JVGQlehbpyyGSZyJcicUh9ZFOZnXrkMH21DUdyqDSKpUsaq6NleNF3GwqmrK0A+J
4TNwFY2j142s3idfnB53rxiiXDDURSGc1HpruGMqGZH931pU0GdK42n5CtTT3nDe
LnYARWLtYW2FlLbfu2bOlThQuSOqdZAn3HUw00fRBXcJqE0bNNGPkezN4ShfrqAP
4BnXwlSc2j15u4+QazGRCuRtHfBP5rnXFa6Rb+bjFFxOb72FTwwdUf/exrOM4l7y
xSd5c08T9hXvZWADzBGmnO6IEiSSP/2hQk4inoY2UsXxSoxGMWYqYxN2KIT9NxrW
s+gdA/aXdMB4pqI5uM9avbKWv5sixren1VRCfbjJg1Id3p6LMpC4TJTFSWjfEJxu
H/54ycyGrYRDt/syfqfcFXxexLA87uVnP2NaTVDwenOAzoFp6PxFKn+KhZ+WhRWp
LInOU77KFbC3rK94EOVWq7CRzcmDyBc1Wc931S1dkSL7ZBvgnSf6jX08KUAoQzWM
53gyWNhkd0rTgEHMWiWID2oJctx8pFBh30puRWW7mejOYEoPQL5atRvZ5aokTAc7
JaNa1wGakWoKrSOj27T93ed/KylRoOqnOH5PdCcQ3Zv69zc5e17Xpa4cLYQDFcTQ
847+WTLeXZk=
=NSXw
-----END PGP SIGNATURE-----

--=-G4lvbkVisl3hvEGj4mrA--
