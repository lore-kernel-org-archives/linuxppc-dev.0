Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E73221A0745
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 01:50:49 +1100 (AEDT)
Date: Thu, 12 Mar 2015 15:50:49 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Eddie Huang <eddie.huang@mediatek.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 03/12] i2c: at91: make use of the new infrastructure for
 quirks
Message-ID: <20150312145049.GA9572@katana>
References: <1424880126-15047-1-git-send-email-wsa@the-dreams.de>
 <1424880126-15047-4-git-send-email-wsa@the-dreams.de>
 <20150308082845.GB1904@katana>
 <20150310135520.GY9132@odux.rfo.atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
In-Reply-To: <20150310135520.GY9132@odux.rfo.atmel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> You can add my=20
>=20
> Acked-by and Tested-By: Ludovic Desroches <ludovic.desroches@atmel.com>
>=20
> Tested on sama5d3, some problems with at24 eeprom on sama5d4 but it
> doesn't come from the i2c quirks patch series.

Thanks for testing! Are the eeprom problems something which needs fixing
upstream?


--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVAafIAAoJEBQN5MwUoCm2lyQP/jILqA5ITnGfCNuV6tGp7lPY
DdMbdr2QT/0kbeo0cX8laa5KfA83MO+AlmMFSWlR1pCQOpFvtBfCWUGxuGhwT7Pr
x4FKE2StJFKbgu86b4NCFslKLmLpii1olh4OOleKcupFsMCiNA70XiTjW9rU+jrA
U8G4K8j7d2xjHXirFdG3gkPRuMDFZDZH11dcvZOk+dbPfeb3DzwTemKz1FDctpu1
VtAQCoFQJK9WA7qtjwt1Cq/ds4CAhR1iv8jbZ5My2gB5q3XGRUspezVCSCq5MV4B
HEGHaon9kXzZusR27zZzYSiStEJ7RNvtf82hmAK/TtEDoowNRoE5/rmQ1D8nmWCy
PPmWPB/X9XRYZXqXBpQXRDj+AI8DWji99210vAxeoCtckfWJUs/UuR8A/Y02wgwD
/UKxLJzU/yRHkjS6ClWuW7cbICDIa/kWTfly0TMIZFxG2+i4z93X2ZNXF1rQ7VgY
h6vP27LYHorJ9bRYjUFQAk2IUNZvTSW7Ir8lyvVs4Os+ZDtcnp2AeRa5h+LSDC0t
m6jUWpndpZihWvga/S5B1IVyGKKc+3CfQUG8WIaox89Z9j7OOaTL5kePBhwON+6z
UiDNGc9tnnl6eoNfRKL4hUu6sEtO2fJ1UAbml0Zyo79llOnzn4XjbfXKhThBP8t/
aVXGxC1SpKU9jIsNMGkO
=qkc8
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
