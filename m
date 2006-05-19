Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BEA2867A5D
	for <linuxppc-dev@ozlabs.org>; Sat, 20 May 2006 00:41:25 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Wolfgang Pfeiffer <roto@gmx.net>
In-Reply-To: <20060519144028.GA2831@localhost>
References: <1147860564.14395.6.camel@johannes>
	<20060517215412.GA4504@localhost> <20060517221945.GA2902@localhost>
	<1147947192.15507.40.camel@johannes> <20060518181748.GA2836@localhost>
	<1148043018.3864.6.camel@johannes.berg>
	<20060519144028.GA2831@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-xeZQM8xQWe5zPJw8F+gd"
Date: Fri, 19 May 2006 16:40:58 +0200
Message-Id: <1148049658.6228.11.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-xeZQM8xQWe5zPJw8F+gd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-19 at 16:40 +0200, Wolfgang Pfeiffer wrote:

> ... because it's the job of alsaconf, too, to figure that
> out. IINM. And because I thought it might help to mention the issue,
> when I was already at it .. :)

:)
I never used alsaconf, and frankly, for PCI cards and anything else
that's sensible I don't see the point since the kernel along with
hotplugging can get it just to work. With ISA, well, yea, maybe. Or does
alsaconf have any other function than detecting the hardware and loading
the right modules?

johannes

--=-xeZQM8xQWe5zPJw8F+gd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARG3Y96Vg1VMiehFYAQJvgxAAmWt9JZ22SMiToUoMbW1dJOEak4w7SONp
PpkdBleY2993YrzbYkVKtB9ouiXb6fOmNudmRbq9Xi6MgVjZ0GVanNFmey89uVMw
U208D0O/NIlN36grJhboCDrrN+L/g7daoIErwdqIqgMIMdozJlDipUhcI6P/eC40
FVBLTYvrCwzuE5YrruJz5heCPZehOcN9hVPZeyqG7bcU8oHg7Gr05z86JtUGb+2b
NQzwZJy0Mr0kJHwre7PI4TYk8PwS31sQXqYlX/KXWkfVEIOuBDpG1MYTxLzJAch+
xtrBrNp2ZswP4Ox76ovF0EVw1B/qEuiiXaviBBGbZuCRIYsrS3NFbShtSGHNpGvM
Ynar4Na5FiMy2yGkH7dpKaaOw/Bgb5TOu0s+P/JCzZ/iozsZGueVGSV94ahliajm
nGULjZnTWEcy2NjLA4/1QLY8FlbavcBQeuoUdCTnqzd1IXyy4kqPLBakpaJrjsTi
nhODmtiK7m0bRfIXkbStIebTVBbRR8qvpdAmFJa03Dl02VnVzB3SqvA5NiWrKMJY
c99BS4uvOWonTzNgWThawx2LRtvqD4jRCv6vECbbSmLSuq50zDYK2YvEF0j8R6cZ
Zy/JG5EFKVik+JfHCw0u/2A4jryD4CDf5+C8wzXbscFl18Q8XVgHimOmJdiUe6Ck
CUoeqOKsW0Y=
=Oxr0
-----END PGP SIGNATURE-----

--=-xeZQM8xQWe5zPJw8F+gd--
