Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 98A1B67A63
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 04:44:05 +1000 (EST)
Subject: Re: [PATCH] Make cpufreq_transition_notifier a raw notifier
From: Johannes Berg <johannes@sipsolutions.net>
To: Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <Pine.LNX.4.44L0.0605251332260.8473-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0605251332260.8473-100000@iolanthe.rowland.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-tGfjN9Jh4zUGpPv1rte4"
Date: Thu, 25 May 2006 20:41:29 +0200
Message-Id: <1148582489.11759.42.camel@johannes.berg>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	cpufreq@lists.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-tGfjN9Jh4zUGpPv1rte4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-25 at 13:53 -0400, Alan Stern wrote:

> Here's the patch Andrew asked for.  I have no idea whether it will solve=20
> any of these problems, and I'm certain that in the long run we shouldn't=20
> keep it.  Perhaps it will at least help stabilize 2.6.17.
>=20
> It's up to you guys to see if the patch helps at all and to decide whethe=
r=20
> or not it should be applied.

Maybe I should note that I don't actually have seen any problems because
of this, the kernel just warns about it. I guess that's because the
semaphore won't ever actually be contended at that point.

johannes

--=-tGfjN9Jh4zUGpPv1rte4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHX6VqVg1VMiehFYAQL6JRAAorE3YEO4n3oKutCXO4RvksGYJ6uPmKx7
/TSPrkR4/iBfh2Wu5NQX7MisGBmEASEoFD2nEQVOY2xs65G0wI5vG3YAM8C35SKG
9vUZRXbXUDlYuBiCSo9ACxFMsl5qTV1IhMaZLjtcyDrihDBOJq0msLErvCZb3mPc
FOTBf27B3EatrM+HFXyrDbiqNQMlCNOJ2ixqmlvAKfyXttj6lFXMgcYhLTxw1yeD
pMRRiyM6aI01dlRaMQ1h2rGMcVitXXC23Nuf2WO+CONj5jWX2punOIhjhkTu+SRc
udY4mq0V/VH4DRA1ppqKJAkuycRkUXvzNi8qpTB20ZMn8MWcAQNW3m/OyOPxO1Ug
bHQ3mH4Sw3XQ21sE+g72GQ3V6TTfdmNz1M/iw65BrGbmDAm5XAJiHobuxXHdKc7m
/eafmWrFstyLS+bk3RxSmfy4Xijd7f93ZJlReAw+Gag2dLY15t0lO4kMRtuHqeom
cbbng6TJ0whUk94kKi5+oH6t2KKJYu4BrFM6Hhg9g4ce2SoYhTedzYBAA0mldrh/
u8Jiz80ZZRVs6WXpMtA5bCllVWvrDH/9ayyYf7zdCPYNdKugCk61i/x3GwBCaVjI
EpHxgcW6V167f6ChnvhpEmLoydDG70MJ8sVbZngKLRsUMju6+GRvARJvUHDqNqTj
XV8v/3H3OmM=
=r/jT
-----END PGP SIGNATURE-----

--=-tGfjN9Jh4zUGpPv1rte4--
