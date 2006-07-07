Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7506C67B53
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 18:22:53 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 01/12] snd-powermac: no longer
	handle	anything with a layout-id property
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1152260005.9862.53.camel@localhost.localdomain>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
	<s5hac7yvfhe.wl%tiwai@suse.de> <jehd26aa25.fsf@sykes.suse.de>
	<jeu0631xpr.fsf@sykes.suse.de> <1151619973.22380.50.camel@mindpipe>
	<jehd231rjx.fsf@sykes.suse.de>
	<1152250720.9862.32.camel@localhost.localdomain>
	<1152259477.15068.15.camel@localhost>
	<1152260005.9862.53.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-TkXpQI0LYMuBogDIuLYp"
Date: Fri, 07 Jul 2006 10:22:44 +0200
Message-Id: <1152260564.15068.20.camel@localhost>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
	netstar@gatheringofgray.com, linuxppc-dev@ozlabs.org,
	Lee Revell <rlrevell@joe-job.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-TkXpQI0LYMuBogDIuLYp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-07 at 18:13 +1000, Benjamin Herrenschmidt wrote:

> Maybe ... or not... I'd rather not bother. I think Alsa should be able
> to create softvol if there is no Master volume...

But how long should it wait for the master volume to become available?
Thing is, as far as I understand this, the mixer is dynamic and you can
add and remove things at any time essentially. No one does, but that's
another story.

johannes

--=-TkXpQI0LYMuBogDIuLYp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARK4Z0aVg1VMiehFYAQIckw//cQnUujl+RT4Bbaifc4Wj8V5kqrLyXhBL
BfJiaHwqGKKtkz1MWRXGy7VWsfbR+G60kAuxlEJaCR+w3KYBn8UneQQMmLFxBrSf
Kmy0xlH6DdxbPaNN4yK8EYntbWP7uX2EeIOVr0WJ/vr2piTGA2Ekg24wct34r25W
XCIinD8W4skevV1fNQ8O5fNdGefEAwLJrFypbJQBTs305EjBXi/WxEiXfdhDg0XD
C5/RBEUCsnPioXeuy2yGeHW/oVpAfWGLcnxHXHZskYeGYk44NaMLhWyctWmSQH4n
y0sSDwcz1bXpoOXIaTl8T5QCQAVwm+23h9WMlP3yfG6MuzzeD/8b9Fq5tZegGv08
FIcTLmIq+kaXiZvZWEG88KLiBnZjcoECns8TiS07FwP8EAxyOjkzJPhf9Q2ypnLg
jFhnzXbYM7Gs2VY966E/5/jo204xwKjdpnQ0HRpwJ+EKPe37JptbOz1iPCcUbmA6
LjN+alzetJBM2e9CU6oD5IMrHzHqdBjS1DdSoIlfj00XqYNKx/YMW6tICclCvlib
hXdLXSEJM0VcCqxd4zW3u268fBEfA/47nhqdkffgkgTCOBfH6l+lNIhnvD3ZbVTF
n1VNWqACL01wsDVK8MA+um1kwO7k7zV9zl1dqcrxTbrG3C3dAZpKV0NMhLsSzZGM
c7WANAN4z3E=
=K4HQ
-----END PGP SIGNATURE-----

--=-TkXpQI0LYMuBogDIuLYp--
