Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zSHyg4pgbzDr25
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jan 2018 10:18:19 +1100 (AEDT)
Date: Fri, 26 Jan 2018 00:12:19 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Frank Rowand <frowand.list@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 devicetree@vger.kernel.org, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-renesas-soc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Rob Herring <robh+dt@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/1] of: easier debugging for node life cycle issues
Message-ID: <20180125231219.mkgai2yurkj3f7ph@ninjato>
References: <20180121143117.19805-1-wsa+renesas@sang-engineering.com>
 <ac4f02e1-6d49-158a-4fb6-56ac0d474a44@gmail.com>
 <20180122114948.mm5mg6zqw3hmjj4o@katana>
 <11cf8fac-d2fe-ecdb-546f-de3c3b42a637@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dit7kcf37pndecqz"
In-Reply-To: <11cf8fac-d2fe-ecdb-546f-de3c3b42a637@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dit7kcf37pndecqz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Frank,

here seems to be a misunderstanding going on. I don't want to push this
patch upstream against all odds. I merely wanted to find out what the
status of this patch is. Because one possibility was that it had just
been forgotten...

> > So, I thought reposting would be a good way of finding out if your
> > concerns were addressed in the discussion or not. If I overlooked
>=20
> Then you should have stated that there were concerns raised in the
> discussion and asked me if my concerns were addressed.

=46rom my perspective, I have done that:

I marked the patch as RFC. I put you on the CC list. I asked about the
possibility of applying it. It was not very elaborate, but hey, this is
just a simple debugging patch :)

I totally would have accepted a high level "No, that won't fly
because...". Or a high level "This and that would need a change". Or
something like that. I intentionally sent this out as RFC because I know
there is some testing missing. I wanted to know if it is worth taking
further steps with this patch.

So, I simply wanted to know if you (still) have fundamental issues with
the patch? That needs to be discussed first before we go into coding
details. I think it is fine to not apply it if there are reasons. I'd
like to know them, however, for a better understanding.

For me, this is a super-super-side project, so if it causes too much
hazzle, I just leave it here and know interested people can find it
easier now. But if it could be applied with a sane amount of effort, I
was offering that.

Was that understandable?

Kind regards,

   Wolfram


--dit7kcf37pndecqz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlpqZE0ACgkQFA3kzBSg
KbaqOQ//U5b/tHeTPx+7dlv9PqVz4A0YcYIXCrtP/+rXOpBwWJBzHjh2eO7tTglD
AvrBFrHZi9DIAOBXTliqwqTFCqwguc1S4pAMMOFqqxYHrbYF0bpN401iVSxeoU3S
irhrH7bEHoIq6hI1Apg88tlIBIz6NP6ISutsFqN2CDbv8sUFvyPJwj4DQbf4/gLo
2JfPmiT5guKssyKwCHgue/fRvM8xn5TTkPGNAPtXJSfmkGur1Op9iHP1WQQ36JeL
mGQlz1nCWcsbqTXCtyToURJnROsQk10A6SKafnX1FsJ10l+vUVBm+9/Kzkzewcis
XbnsWmQX+cSIZBSuTMxwXk9qQiYzU0E9nH678HjT9R+FHWZNm1wTo7ssuyZYxNOV
rt9EIjW/wCwts9tvvT+Rsjq+Twh5VeqQyd3nAyyFlwJauWVqB4159JM7+keD8g0O
kKPXhU3akKji34oZERVwrAV3rlyiwDr/kdq6BY2YIHCW8Gpt6/H7IsIArfBrA+iq
4QZJrV/Ffu8Af8Vw1uGDahOmlCCO4FhcNv2SfP7RISJBxTa0zqFS2AHriTwmHlS5
pJDmzMNVDuxIk6vjVpq6m4OpMnwnkjSHnJ50SXKtd0zxclnONzxDHvxb/hzGkpgf
BKPJjEdau0yXwplJPQ5YgHEnPOLCP0GcKGBD4bKfuvGX7HuM3MY=
=AkWb
-----END PGP SIGNATURE-----

--dit7kcf37pndecqz--
