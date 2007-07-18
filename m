Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 839E9DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Jul 2007 06:01:41 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBFi9-0000Ie-28
	for linuxppc-embedded@ozlabs.org; Wed, 18 Jul 2007 22:01:25 +0200
Received: from dslb-084-056-181-006.pools.arcor-ip.net ([84.56.181.6])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 18 Jul 2007 22:01:25 +0200
Received: from mls.JOFT by dslb-084-056-181-006.pools.arcor-ip.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 18 Jul 2007 22:01:25 +0200
To: linuxppc-embedded@ozlabs.org
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Subject: Re: can anyone help me to test my ac97 driver
Date: Wed, 18 Jul 2007 22:01:08 +0200
Message-ID: <1184788868.18032.22.camel@localhost>
References: <165516780.1952051184304174471.JavaMail.coremail@bj163app130.163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-on8rfS4l9ztJ8DY3ppxn"
In-Reply-To: <165516780.1952051184304174471.JavaMail.coremail@bj163app130.163.com>
Sender: news <news@sea.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--=-on8rfS4l9ztJ8DY3ppxn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi silicom,

On Fri, 2007-07-13 at 13:22 +0800, silicom wrote:
> I have a simple oss ac97 playback driver for xilinx ml403 and
> linux2.6.17 kernel,but when I test it with a *.wav file with sample
> rate 44.1k, there is much noisy, and I want to know whether there's
> problem with my ml403 board or ac97 driver,could anyone be kind to
> help me test it on your board or point out my problem?

Today I took some time and tried to compile your driver, but one of the
first things I saw was that there is a file missing: "xac97_l.h". I
think, it contains your "low level" functions. If you post the file, and
I have some time, I'll test your driver and what it does on the board,
which I have available.
Furthermore your driver depends on xbasic_types.c/h, xio.c/h, which some
people might not have, too ... especially xio.c/h (in my
experience ;-) ) ...

In my last mail (last week) I announced my driver for the AC97
Controller of Xilinx and said that I'm going to release/post it. Since
then, I worked on it once more and now it seems to be pretty stable and
usable (playback support). I added capture support, too.
[Capturing basically works, but there is a problem with higher rates and
ALSA not reading from the intermediate buffer anymore ... not yet
investigated.]

My driver will be published on a website soon. I'll post the link as
soon as possible. Meanwhile, if you or anyone want to try it, just mail
me (JOFT@gmx.de).

 Joachim



--=-on8rfS4l9ztJ8DY3ppxn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBGnnGEZY86bR8HqNwRAv/1AJ4w0hO0wf+DROcGvFuQ4G2eGy3IxgCfWwBL
cPzF6yhI3rpbZo6ta9JPhqU=
=npcL
-----END PGP SIGNATURE-----

--=-on8rfS4l9ztJ8DY3ppxn--
