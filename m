Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 539BD689D8
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2006 22:20:55 +1100 (EST)
Date: Wed, 18 Jan 2006 12:20:49 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Frank Arnold <frank@scirocco-5v-turbo.de>
Subject: Re: Feedback: Support for fn key on Apple PowerBooks
Message-ID: <20060118112049.GA32634@hansmi.ch>
References: <1137580063.3466.134.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
In-Reply-To: <1137580063.3466.134.camel@localhost>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2006 at 11:27:43AM +0100, Frank Arnold wrote:
> I have some trouble with it. Actually, the mapping of function keys F1
> to F10 seems to be inverse. I have to press fn + function key to get a
> plain function key event. Pressing a function key only gives me those
> fancy new keycodes for brightness, mute, and so on. Page up, Page down,
> Home, and End are working like expected.

Mac OS X behaviour (default):
echo 1 > /sys/modules/usbhid/parameters/pb_fnmode

F keys first:
echo 2 > /sys/modules/usbhid/parameters/pb_fnmode

Disable special keys completly, but report Fn to userland:
echo 0 > /sys/modules/usbhid/parameters/pb_fnmode

You could have been able to find that out easily by looking at the
source code.

Greets,
Michael

--=20
Gentoo Linux developer, http://hansmi.ch/, http://forkbomb.ch/
"Besides, I think [Slackware] sounds better than 'Microsoft,' don't you?"
(By Patrick Volkerding)

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDziSR6J0saEpRu+oRAt7yAKCFGTlkwHiHJVWXxGqnctzI56tncACfXeuR
RFqxHaldegP6ruSBlVWJTRc=
=V9oX
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
