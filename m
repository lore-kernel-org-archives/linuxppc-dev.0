Return-Path: <shtrom@zorglub.ssji.net>
Received: from whymper.ssji.net (whymper.ssji.net [213.41.140.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5884268734
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Nov 2005 00:19:16 +1100 (EST)
Received: from mudrublic.csbnet.se ([193.11.243.56] helo=gloduk.narf.ssji.net)
	by whymper.ssji.net with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.50)
	id 1EcjL7-0003D8-Ab
	for linuxppc-dev@ozlabs.org; Thu, 17 Nov 2005 13:58:09 +0100
Date: Thu, 17 Nov 2005 13:58:04 +0100
From: Olivier Mehani <shtrom@ssji.net>
To: linuxppc-dev@ozlabs.org
Message-Id: <20051117135804.7a320dbe.shtrom@ssji.net>
In-Reply-To: <200511171234.31085.lkml@oxley.org>
References: <200511170213.16926.lkml@oxley.org>
	<Pine.LNX.4.60.0511161918050.29361@tin.icics.ubc.ca>
	<200511171234.31085.lkml@oxley.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__17_Nov_2005_13_58_04_+0100_XnHKcjPGt6xc3wmE"
Subject: Re: [REQUEST] Tap for right click on PowerBook trackpad
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__17_Nov_2005_13_58_04_+0100_XnHKcjPGt6xc3wmE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Nov 2005 12:34:29 +0000
Felix Oxley <lkml@oxley.org> wrote:
> Actually, ububtu which I was experimenting with had this feature
> enabled by default. However I find it extremely cumbersome to have to
> remove my hand form the trackpad in order to press F12.

If I'm not mistaken, the default mapping are fn+Alt for right click and
fn+Ctrl for middle click, which I find much more convenient than F11
and F12 on my iBook (closer to the trackpad).

> I believe the Linux trackpad driver can do other specail action such
> as 'click and drag' or something  similar. Therefore I was/am hoping
> that implementing tap for right click would be possible.

I'm adding my own question as it is almost the same topic:
Is it possible to have the same behavior as with synaptics touchpads
(scrolling) ? I've googled but didn't find any sure answer.

--=20
Olivier Mehani <shtrom@ssji.net>
PGP fingerprint: 3720 A1F7 1367 9FA3 C654 6DFB 6845 4071 E346 2FD1

--Signature=_Thu__17_Nov_2005_13_58_04_+0100_XnHKcjPGt6xc3wmE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDfH5faEVAceNGL9ERAgFdAJ9iRFxf0uvY3Czl3uHCfBjgwH9lPQCfTHWP
j52o4KlZHO5gjkGKI8+8pVA=
=hzxm
-----END PGP SIGNATURE-----

--Signature=_Thu__17_Nov_2005_13_58_04_+0100_XnHKcjPGt6xc3wmE--
