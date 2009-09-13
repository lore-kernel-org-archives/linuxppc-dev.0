Return-Path: <albrecht.dress@arcor.de>
Received: from smtp6.netcologne.de (smtp6.netcologne.de [194.8.194.26])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 7BBEBB6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 14 Sep 2009 02:22:59 +1000 (EST)
Received: from antares (xdsl-78-34-247-251.netcologne.de [78.34.247.251])
	by smtp6.netcologne.de (Postfix) with ESMTP id DDDE52A0558
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Sep 2009 18:13:56 +0200 (CEST)
Received: from antares (localhost [127.0.0.1])
	by antares (Postfix) with ESMTPS id 987DABA167
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 13 Sep 2009 18:13:54 +0200 (CEST)
Date: Sun, 13 Sep 2009 18:13:53 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: MPC5200/BestComm functions question
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <fa686aa40909120701k4c4faa8ev78ac556f0b1f88ed@mail.gmail.com>
	(from grant.likely@secretlab.ca on Sat Sep 12 16:01:35 2009)
Message-Id: <1252858433.3337.2@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg=PGP-SHA1; boundary="=-eJvUJp7Jd7nJm7n39cPZ"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-eJvUJp7Jd7nJm7n39cPZ
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 12.09.09 16:01 schrieb(en) Grant Likely:

> I've actually got a better driver which exports an API for doing =20
> local plus bus FIFO transfers.  It's been posted to the mailing list =20
> a couple of times.  I'll cc: you the next time I post it (real soon =20
> now).

Thanks a lot, that will be really helpful! :-)

> Bestcomm can do that, but Freescale has not publically released the =20
> bestcomm documentation, and they do not support writing custom =20
> bestcomm tasks.  From what I understand there are a number of hidden =20
> bugs in the bestcomm engine which you could run into if you deviate =20
> from the provided tasks.  You're very much on your own if you go down =20
> that route.  :-(

I see - that's a pity, shifting those tasks to a "coprocessor" sounds =20
like an attractive idea!

BTW, I didn't forget about the 5200 GPT/WDT issue, I just didn't have =20
the time yet to implement it.  The old work vs. what I would like to do =20
conflict, but I will try to find a reasonable solution.

Thanks, Albrecht.

--=-eJvUJp7Jd7nJm7n39cPZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKrRpBn/9unNAn/9ERAohEAJ0aytmFy4ol2HnzSWMguvKRVXTLMACglNOA
UEpUL1DvgrEmd6zJheCB4zc=
=DGb/
-----END PGP SIGNATURE-----

--=-eJvUJp7Jd7nJm7n39cPZ--
