Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9D3EDDDFC
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 00:10:22 +1000 (EST)
Subject: Re: [RFC/PATCH 2/2] powerpc: irqtrace support to 64-bit powerpc
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20071015072826.2D541DDE16@ozlabs.org>
References: <20071015072826.2D541DDE16@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-RWzIvSHN54G1IA7Dc+Kg"
Date: Mon, 22 Oct 2007 15:35:07 +0200
Message-Id: <1193060107.9793.8.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-RWzIvSHN54G1IA7Dc+Kg
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-10-15 at 17:28 +1000, Benjamin Herrenschmidt wrote:
> This adds the low level irq tracing hooks to the powerpc architecture
> needed to enable full lockdep functionality
>=20
> Some rework from Johannes initial version, removing the asm trampoline th=
at
> isn't needed (thus improving perfs) and fixing a couple of bugs such as
> incorrect initial preempt_count on the softirq alternate stack.

Hmm. It breaks booting on my quad, I finally got around to testing
without this patch and it turns out that it caused the boot failure I
reported in another mail. This is with v2.6.23-6623-g55b70a0, a clean
tree boots fine but with these two patches applied and configured in it
fails during boot, hanging at some point, apparently when userspace is
entered.

On the other hand, it is fine with my original version. I'll have to
find some time to check the differences hunk by hunk I guess.

johannes

--=-RWzIvSHN54G1IA7Dc+Kg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARxynCqVg1VMiehFYAQLMww/+KS3a+txd7f1X9LgQ2FeI/XvoX813cMd9
rNxKylgMH8eL30aYtOu927UjZr7H+trwbU1UQAkOsP+baiGiXiejPfxVXW1xeN74
SHrQGaWQBi9EmuO0E1Nl7/HJtF8TQiUyfGTfdhFoeV9i8XLFSkKyNwBPFxsO/UTT
qkleN1IN79N3XxyhPXcv6gjAAdxB1rr+yfrx/e6v1oSL4tcnYH87BTQkUCKVHgNc
fkdFX8oimx1lTHjWY+kplr0l/T/wpHoMRvj3pzCeTlrlIek4A2bVmvposatleHeJ
R7yIxSY0QBs6bP1nupmQCQHaS2FWE4d9kxsCH1nTXQ5pXrK8TG3+XF9cEuh+1t/5
fI9J7DrO6j8Hrfr9p40HZt4BW20dxJ7ui5x7kUM3laMS4SSsWXJJ0gvKzHUeFTxb
0sWMXPDo7nUOK/zg0j3N9TfabvmQ6KM+xNaLpU9XeuoilTIDc+huoFumODMKQwWC
3dCn8jgfOl+aIGMXAZ0+llkCN4ibrxZzry7nhXqxcBRyXbGcVDHsAk8w5ndlx2ca
KflRo9uGVykPUzVPCJ7HV3ziiPsI5vyboGMVI9IwGOm2Z9pjnFMCgAJgE6ZDf9X0
7UQXNx+TeU2t7b5SPtvldsXRziJLMPAwpgr6uuJG53t/+n6/pG0fefRgIHbJl8PZ
nEk5Ek4j5fc=
=U/0y
-----END PGP SIGNATURE-----

--=-RWzIvSHN54G1IA7Dc+Kg--
