Return-Path: <johannes@sipsolutions.net>
Subject: Re: mpc5200, sysctl table check failed
From: Johannes Berg <johannes@sipsolutions.net>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071107204138.GA7066@lixom.net>
References: <9e4733910711071224v7bf643bahba0fd23eb2d16ee1@mail.gmail.com>
	<20071107204138.GA7066@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-/HbObaIcyM86iIDLlegN"
Date: Thu, 08 Nov 2007 16:09:39 +0100
Message-Id: <1194534579.6294.46.camel@johannes.berg>
Mime-Version: 1.0
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-/HbObaIcyM86iIDLlegN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



> I posted a patch for this yesterday, it's harmless, just a warning.

That's not actually true, if the sysctl check code warns in any way the
sysctl file doesn't show up in /proc/sys/

johannes

--=-/HbObaIcyM86iIDLlegN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzMmsqVg1VMiehFYAQIsWw/9GPqdldsJfwkpz2EIKNpzlU7+liqUjNWI
Ly2XoofgJc3B4JqtoGayQKyc2j5pdNBPTVx7tZbxoK/o4587HUbff/K0NCGaJ4ww
oVDPFP0cqnh1ryWFnAkaVr9QNzGZvItB32FjJX4/A7YjENFHVlnSOE3eFVV5vZVo
RSwDIsw/l7hEZBcUM0dirGT1rOV46KBR3KhhrG7OWdsZGsx1StN+yj/Yo751YsOP
JbaDcSBbhzJhUBHp7mheDJaIXbzcWYXU0er6c7Lt9nQMnV8/XIf9GWh4JAGR5UlY
bQZnrCdQLdNWl7kDAwMR/pnPrBThbwYpr/ipP5gW6b///MiHBenKxGeugQLvSFa7
/KRjO41+MNrcRZuwi2N57ihyWQTj97hvufRfqZHLMpxG+tOOvg6mfYb7r5PEkQwx
KdLqRHGOjz+HcWYpQRZ4hX3y7kHkdyzPCovr9qu9Kiydwb3ZgAFiowHVQVYlUpjc
TDa/zP27CotozBugLDKzVWKnodiecrdnwt0umMbMVloH8sZE7xBzuscQMNXI8gu6
BkDmn3u35EGi2m8xVzJxixjtNheoEOkjxkXd/CszRGrzChr7n8Ino6KUr8NgfACX
qggYHwaH1tQl3EwOzws4Aqkbk2pMo9xZpx6NhYtjEoK112jAExC7ifKtqPPsHzXL
EjLToql823s=
=aIaW
-----END PGP SIGNATURE-----

--=-/HbObaIcyM86iIDLlegN--
