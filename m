Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4E121A0CD2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 02:00:31 +1100 (AEDT)
Date: Mon, 19 Jan 2015 16:00:11 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [RFC 01/11] i2c: add quirk structure to describe adapter flaws
Message-ID: <20150119150010.GA3820@katana>
References: <1420824103-24169-1-git-send-email-wsa@the-dreams.de>
 <1420824103-24169-2-git-send-email-wsa@the-dreams.de>
 <1421396295.11671.50.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
In-Reply-To: <1421396295.11671.50.camel@mtksdaap41>
Cc: Xudong Chen <xudong.chen@mediatek.com>, linux-mips@linux-mips.org,
 linux-kernel@vger.kernel.org, Liguo Zhang <Liguo.Zhang@mediatek.com>,
 Ludovic Desroches <ludovic.desroches@atmel.com>, linux-i2c@vger.kernel.org,
 Eddie Huang <eddie.huang@mediatek.com>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> This can describe the behavior of our current upstream driver[1], which
> only support combine write-then-read.
>=20
> After checking with Xudong & HW guys, it seems our HW can do more.=20
> On MT8135, it can support at most 2 messages, no matter read or write,
> with the limitation that the length of the second message must <=3D
> 31bytes.
>=20
> So this RFC is enough for our driver, but it would be better if we could
> also support other case.

Hmm, I think we can convert max_comb_{read|write}_len to
max_comb_{1st|2nd}_msg_len or similar.

I'll check but it will probably not before next week.

Thanks for the input!


--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUvRv6AAoJEBQN5MwUoCm2BtUP/j0J77NsM7yPGZCkW0ukxlje
DlX4KwNdJfkLoKAXA4Mihfl33bzS7Vs7S0LN9ZSAu2wgxp5kl/+ZKMMCIauMLt1o
CYtAZuHvQBMPmsDRyumir597NOE9oDd31ttZs3USzwG5SiIHSGh1yU/MMHezG5Qp
HxyQ42NhSUY55h88FEHm3GrEXCBJ3JS765t7USm6/HriyvHoPrzS+X8dhvPWwZup
u8LRbL10HYHjYNXBo918+KvHvMO8tmVET/tqqShcLsTo1+xadr9p3xzuqu7VwETX
j7UgnJtkpBv1xftkqp3vVNQ6seLPd/ozaIdTfHtnIPlD3f9aGZBIcHS9uOBtwfuJ
ptR0EFR0RYDws84ipI85veGB7QTJOlKonSyGKfSIdvmjMGwSnVCBe2wO6jWv9IWw
d76+/R/53nwI+IyZK99wmzDNfMhK4EVybKzdLqtt4/7RYlifGB79Vrorlo9t26hD
XnJNxUAJZiwn9yaoeuKI/pH67tGKfjMGe3A7+HISdaSwwAn5aLLWggBeI9pIHB6r
ZeoXhSXK3RskAM5/50OpwPfXn/oMCq/XUBycBRJwXzQs+ab49wD+ptX/QCXqk4N0
vGnrT41MLD+U6mhgwtLqd9idT7U1lg44cbe8lBmnhbhaYwhp+L01HJbaK6ALfEJy
VESLiRjTpngaAEIGYvQH
=GLeY
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
