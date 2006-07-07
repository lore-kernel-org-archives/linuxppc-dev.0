Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A046E67B65
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Jul 2006 19:55:24 +1000 (EST)
Subject: Re: [Alsa-devel] [RFC 01/12] snd-powermac: no
	longer	handle	anything with a layout-id property
From: Johannes Berg <johannes@sipsolutions.net>
To: Takashi Iwai <tiwai@suse.de>
In-Reply-To: <s5hpsghwxny.wl%tiwai@suse.de>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
	<s5hac7yvfhe.wl%tiwai@suse.de> <jehd26aa25.fsf@sykes.suse.de>
	<jeu0631xpr.fsf@sykes.suse.de> <1151619973.22380.50.camel@mindpipe>
	<jehd231rjx.fsf@sykes.suse.de>
	<1152250720.9862.32.camel@localhost.localdomain>
	<s5hpsghwxny.wl%tiwai@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-HaeAWssTSe3NyMMqNg66"
Date: Fri, 07 Jul 2006 11:55:06 +0200
Message-Id: <1152266106.15068.34.camel@localhost>
Mime-Version: 1.0
Cc: alsa-devel@alsa-project.org, netstar@gatheringofgray.com,
	linuxppc-dev@ozlabs.org, Lee Revell <rlrevell@joe-job.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-HaeAWssTSe3NyMMqNg66
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-07 at 11:51 +0200, Takashi Iwai wrote:

> Currently, it's aliased to PMacToonie.conf, so that "PCM" volume is
> added automatically when no corresponding h/w volume eixsts.

Will submit a patch to name it "PCM" then on tas instead of "PCM1"

johannes

--=-HaeAWssTSe3NyMMqNg66
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARK4veKVg1VMiehFYAQK+/A//U2nLucaP6G1jZy1y462kQ5BX0HSYY5WK
YfoLrGBlBvbqTs6GgWJEhaTx32vBcVZ3HXvf80QJF3ayhvLGQcPpnct3SaVpZ+cS
Qb0+2G8zTnhUOnwfeWs2r8pCmx4emzfZuX28VI3KaAV6ga/Ek2KPIhBWm+230OnY
/wKiiTM09P0XUKSKJM6fKG0IQoSAXHOkz3YNIUnJl4oQpmT7D96w84heS/OPS8bL
snAAZ2rga2waEmkArIZacoljSNp9BYdDoRn3GvgO/gw9yjz69T7TjyBfHfIVPVUA
i/7YqttgzkDCpeSrxnP5hmZqA07tjdQQRp34KO59tgc+6Z2X4FrzOA67x+irVzn+
g3KHhBznNw7mWN6LIQByRc8cR0K2RNv5yk8Jf8VHi0FJ6RplQpwAPp5tYo5P2hyH
fMD3I4nIr6T9tsO+gCc26gnfZzJPix2Fkb1x0t6sEQFqrKqpXWF9JPhaJ4FLVKh5
VdI9ePjt2gAhIEdGd+XQNZ/NucHdVsYr09st3NBIko9Iw93FzKhSxE5Ykde7HpJx
SFNeSIBPaqEauJ53BUlH9mrwrbiPnAsRORe+yD/kDBGEosw40Yr4mfBI/oV9UmRX
NakC21NvgAYnEnbJ9uyBo3AvEigDRMt5qUUp2VGJuvNDlWMW2iEhnvA9DcTd7+Ma
9Aagty/ciLI=
=3KMZ
-----END PGP SIGNATURE-----

--=-HaeAWssTSe3NyMMqNg66--
