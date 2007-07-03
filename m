Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 161F3DDE39
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jul 2007 16:22:09 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I5bly-0007Tu-CA
	for linuxppc-embedded@ozlabs.org; Tue, 03 Jul 2007 08:22:02 +0200
Received: from dslb-084-056-143-151.pools.arcor-ip.net ([84.56.143.151])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 03 Jul 2007 08:22:02 +0200
Received: from mls.JOFT by dslb-084-056-143-151.pools.arcor-ip.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Tue, 03 Jul 2007 08:22:02 +0200
To: linuxppc-embedded@ozlabs.org
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
Subject: Re: Can anyone help me about ac97 driver
Date: Tue, 03 Jul 2007 08:21:55 +0200
Message-ID: <1183443715.5645.19.camel@localhost>
References: <1329478984.2865871183429363889.JavaMail.coremail@bj163app129.163.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1ZHV+PseQ4i+2+8XlwSb"
In-Reply-To: <1329478984.2865871183429363889.JavaMail.coremail@bj163app129.163.com>
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


--=-1ZHV+PseQ4i+2+8XlwSb
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi silicom,

On Tue, 2007-07-03 at 10:22 +0800, silicom wrote:
>     I'm writing an ac97 driver with interrupt mode on xilinx ml403 and
> linux 2.6.17.1 platform but encounter a incredible problem,can anyone
> send me a copy of the driver code.

I read your previous mails (about a problem with the interrupt handler).
Mainly in the last few days/week I wrote an (ALSA) driver for the
"Xilinx ML403 AC97 Controller Ref", too (ATM playback part only, no
record).
And I didn't encounter problems such as your problem. The only
difference I see, is, that I don't have an explicit "write process": INT
is thrown =3D> INT handler: loop, copy data to the FIFO until full =3D>
return from INT handler.

I had serious problems with the "Register Access Finished" bit, which
stops working after (average) ~80 codec register accesses (bit remains
0).

My driver is "working" since yesterday evening ;-) ... so I feel a bit
uncertain about "releasing" it to the public right now. I'm willing to
post/contribute my driver, but that will have to wait some more days/a
week ;-) ...

BTW: Is your driver an ALSA driver, too? Or is it an OSS driver?

 Joachim



--=-1ZHV+PseQ4i+2+8XlwSb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBGiesDZY86bR8HqNwRAqdoAJ9RtfMSHBpzDx60JI1CqzsqsUkFJACgly3c
KNWLajGfW/6uOfR9ohCyMGk=
=K0hW
-----END PGP SIGNATURE-----

--=-1ZHV+PseQ4i+2+8XlwSb--
