Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 127391A0701
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 01:54:54 +1100 (AEDT)
Date: Thu, 12 Mar 2015 15:55:03 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Subject: Re: [RFC V2 04/12] i2c: opal: make use of the new infrastructure for
 quirks
Message-ID: <20150312145503.GB9572@katana>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-5-git-send-email-wsa@the-dreams.de>
 <54FF2631.9050006@linux.vnet.ibm.com>
 <1426029133.17565.9.camel@kernel.crashing.org>
 <54FFC3EC.7020708@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
In-Reply-To: <54FFC3EC.7020708@linux.vnet.ibm.com>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@atmel.com>, linux-i2c@vger.kernel.org,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
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


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I think we can't land up here by-passing the check for quirks so above
> checks are duplicated here..

True.

So, as Ben seems OK with write-then-anything, can you send me your
changes as an incremental patch to mine with your Signed-off, please?

Thanks,

   Wolfram


--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAajHAAoJEBQN5MwUoCm254UP/1g93L0on97oPHJ3A4JfX6ti
+6xQ/c0c+c1kIwpK8dt5LMPNXwNS8+DIk06y2rOwhI9liqVTruWZv+hrKalTGWBK
m63fS0IdwKgSay+G2zd956UH0Do4qsYjdYzxZ5TO2kw37k1Wa9iU4nQ8zHtnwN9I
g6Ri2QZQZdPqfPEu9nsTkxqDmZDr+mB+GwcwZZv1x4nvIST7wA/jmTD7KsKbTxLp
T0ak/qIzL8VwKAswlatxjR69FW4Gi8HVjJY5U8B5+vMZtOtoNL6pVdQIoa2Fhmp+
c7d+D9brYhWp2cps0z7Wz1g7LdBkVpcsrZU+KBn7bAHAYJXpSz4xg13sBvlupsd/
H0cYRpSYBICedY3zyAPu+Ih04RfqP6S+de+DHh7QeUm6VvWqdZ81Uq1iQqUahgE+
yj8kyiJUpTiBwuIkO0KevzncuvSIdYXy98PxgsQYbEkV1/+kRAN4zWHoT1UHPVT/
s1RkcwpWUmm3a1CPYS3M/zzMXr8twdYn5/0AF0g9kfmsLHGW9wZ06Q8IqaV9TFGR
DKYLsA3SVqWEcmbpUCAvwbrL+xcLoxH06QbsBaFFOnmUEFZOVwTUrqsSAkd0+clM
gw5wb9fIswAN8LairYDd8Xe63wA46DZPT/ykkcIe9+xTw0oC2ouDxZzYKvxvuyM/
XLL/alJLDxQzbOayFPjI
=Kxsv
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
