Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AABE467B2B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 23:53:43 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 4/7] snd-aoa: add codecs
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hpshvfwta.wl%tiwai@suse.de>
References: <20060528190026.754474000@johannes.berg>
	<20060528190125.927852000@johannes.berg> <s5h8xol9gom.wl%tiwai@suse.de>
	<1148992996.3102.8.camel@johannes> <s5hr72bbqfm.wl%tiwai@suse.de>
	<1148995575.4372.5.camel@johannes> <s5hmzczbpps.wl%tiwai@suse.de>
	<1148996349.4372.7.camel@johannes>  <s5hpshvfwta.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xkoGql7H/f81wnFrgghD"
Date: Tue, 30 May 2006 15:53:25 +0200
Message-Id: <1148997206.4372.13.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xkoGql7H/f81wnFrgghD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-05-30 at 15:48 +0200, Takashi Iwai wrote:

> Actually the extra notification won't hurt much in practice.
> I've seen that some drivers also don't check the unchanged case and
> return always 1, so apparently the apps work.  But, it's of course
> better to check the state on the driver side.

Yeah, agreed. I'll fix it.

How about making alsamixer actually handle the error cases? In the onyx
codec, there's some things that prohibit changing the s/pdif output if
you dno't use a bitrate that can handle, but alsamixer 'changes' it
anyway...

johannes

--=-xkoGql7H/f81wnFrgghD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHxOU6Vg1VMiehFYAQJ2URAAhnNUEv2U/5vd1Whdj/PboPkawGjcrUYs
XYpdNcDhFWMSrJTbFIziVPWt8LeMdFw2hOI2pWMZj/x64CGteywpDMt/qQgIQ/pL
LuoiJXODDHlmWLKqzBr4Hlm2tLC56KMh7cjvfgAdlsXrc3NXgcwjVqVkUp1vWhGw
pARcK1J//7/h/pjuVem1tcDmQcYKpYBGOc62WqQdiN4NA1JCd5AnqrjrnYnqtInX
Uqta1haaRbfO/LjdbaHHsMOON/eFNU85IR/U794ISZMTaFc4xp4s0hMC51TIfv0m
U6nGA2kHaioVC6hqzQ6pUSn9lJlBiYRHcoln50UaKPGh8yCZwshOWIkpI4nxLaQr
dUlddkVFNaySNj0M5kgLOUft/KgEqCDh+eMI6SH59FbkxTOlz/O59HCFtg65qxMM
5a0v0phJz6C6p2kSpES6yL7my2Al56eAkxP+SpBb2mDrH1S2r+XDppTFqEQQoyR7
xLb145hNsp0bB0oWuun50J0ryqYHpaHQZYxaiYEyE+15Pyn6SmlSpXSVpO6R0k8Q
zXCJmwBwpeZZ5uBudhk0nyMS83rvf63o3A/EXUyIeCNlZSIMVopq4C8osoW3t+HM
QZyqOjZnX5Bhsmg932XIwutu3QRGut2yqVjNACTy+ZMNSlOu28veFGsbRk2jwNXQ
XPnnOZE43zc=
=9SY6
-----END PGP SIGNATURE-----

--=-xkoGql7H/f81wnFrgghD--
