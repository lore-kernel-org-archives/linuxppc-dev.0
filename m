Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABDC9679F7
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 22:24:48 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC] alsa integer control ranges
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hzmhh0yq4.wl%tiwai@suse.de>
References: <1147780945.29795.110.camel@johannes>
	<Pine.LNX.4.61.0605161430220.9330@tm8103.perex-int.cz>
	<1147817058.6753.7.camel@localhost.localdomain>
	<s5hzmhh0yq4.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-KL6qrLewIojKBYSi66Y6"
Date: Wed, 17 May 2006 14:24:36 +0200
Message-Id: <1147868676.15507.14.camel@johannes>
Mime-Version: 1.0
Cc: ALSA development <alsa-devel@alsa-project.org>,
	Benjamin Berg <benjamin@sipsolutions.net>, Jaroslav Kysela <perex@suse.cz>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-KL6qrLewIojKBYSi66Y6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-17 at 11:47 +0200, Takashi Iwai wrote:
>=20
> The mixer stuff is the weakest point in the current ALSA
> implementation, and it has to be sorted out better.=20

Here's another item for the wishlist:

Give applications an option to tell the library they can handle
ENUMERATED controls, and then don't mess with them. And then, if the
application *doesn't* tell the lib it can handle ENUMERATED controls,
split up *all* the enumerated controls instead of just the "Capture
Source" one. The current behaviour:
 - it splits up the Capture Source one but no others
 - it doesn't allow apps to get the real intention

is bogus for the following reasons:
 - most GUI programs get *checkboxes* that are mutually exclusive
 - a lot of GUI programs that cannot handle ENUMERATED items
   totally screw up when they still get an enumerated one just
   because it had a different name.

johannes

--=-KL6qrLewIojKBYSi66Y6
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGsWAqVg1VMiehFYAQJaGhAAi+o/2ELqofFsRY4N7Bq3fqhF+vwCNC6f
0WoZ93IIvfp/CwLOerOeuQqMoYL4+9OGTZT8aAOzibr6g+2Ho8O4Spg4vhSZSfZF
KzefVIMyBZ/JX8CsP5CtcV4EWL9Bg3DmJ9iouG28ch3hp53gTm7Ca0NS4aAg59lx
q29V3WBGzmAyQkuwHVt0ntsV2gjEeCPEPVJ3eK4u2eLMPIjPg7q0mtCZREMc3SOi
ecamP/mg0ptSXo99PVnVQfEaXFSBjb1Qhuuv6v49/m/PgEMPGLmcuXPVm+ZBvt08
wiIIu4J2mAAW5OP7J93S3vTdLbbLstn3DspQVCDnY2GbWP8zUIe4Hggn3OIAeyGO
JQmd998RGQ256shuJh+Umm1dYTdkrCz/CTF6eMZnZJhJI4UmLecNa/2MRRWQcEs5
tgGOWMqKMOqPRunvWvoow/Ym1a9uI47tZaK4PGUHYo/MwMZgZvwnERjXzMBUIysD
g8Jp4omZt4KsDxmLipuqoX/lsB48XmAgLxFGki/WwsvMo3/bfUY6aSei0H6zs5nR
E7B4/bjdNZYTUbUMPlDTdHKkeHkcr0ZyeMpS5ibY5LGlkglu8CSQjEKx7QqgrHjG
/yUbHuw4NR16vlkK26N2stskgdnlUnwNpmngpuuNzRxIjyBih2bJ6GBAxMBmzZWf
CeH6Gw1wqgU=
=9VWJ
-----END PGP SIGNATURE-----

--=-KL6qrLewIojKBYSi66Y6--
