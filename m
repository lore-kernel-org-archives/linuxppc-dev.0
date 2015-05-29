Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 603961A0E2E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 20:50:40 +1000 (AEST)
Date: Fri, 29 May 2015 19:50:22 +0900
From: Wolfram Sang <wsa@the-dreams.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Dan DeVoto <dand1972@yahoo.com>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 alsa-devel@alsa-project.org, linux-i2c@vger.kernel.org,
 Mark Elliott <txlitebeer@gmail.com>
Subject: Re: [alsa-devel] [RFC] sound: ppc: keywest: check if DEQ was already
 instantiated
Message-ID: <20150529105020.GB3168@katana>
References: <1432397711-3186-1-git-send-email-wsa@the-dreams.de>
 <1432631974.85649.YahooMailBasic@web141501.mail.bf1.yahoo.com>
 <s5htwuxb1h4.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
In-Reply-To: <s5htwuxb1h4.wl-tiwai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2015 at 09:33:27AM +0200, Takashi Iwai wrote:
> At Tue, 26 May 2015 02:19:34 -0700,
> Dan DeVoto wrote:
> >=20
> > Hi,
> >=20
> > I applied this patch ("check if DEQ was already instantiated") on top o=
f=20
> > "sound: ppc: keywest: drop using attach adapter" and sound works great.
> > Everything works as expected.  Below is my dmesg output.
>=20
> Very well, shall I merge the patch as is?

Yes, with Dan's tested-by. This patch should get its testing cycle via
linux-next. If no regressions, then it could be considered to send this
patch (and the one it depends on) to stable. They will fix missing sound
issues which regressed ~3 years ago. I'll leave this to you, of course.


--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVaERsAAoJEBQN5MwUoCm26mAP/1HVbHYiv7rV6x+HErFzrBFM
8vFzzfOSJXZLAUGdYuCDvyFhWz7nugORkaFvLUuF4rtaNspTs1e4KPj++W2Tgszw
rzrIIvtYTlqx/IKhbXDPcHBHWSU/GeK3PwETz1QyuHAu49BJcTTmKAlnur74+yDJ
0OzfzlHM1dUlksOw9mleSRNtJd7apEx+blUoIPAu2/n6rh9oEOGlq52nKf2PV5Xq
deMCu8QeNdvVN3GsZFr9Zd7Ybq2GpIQP+N9jdUCpGVrB2qqNQ8U9NJrqAn90UHvf
yPKvZPlbxUSp7RwMZ+3Euy8mjVlWvlDg549bednzsj4xQmTAhWHhkTsCtZVnpf7m
HiNI0hkZuvZsqyy2DVU+szE6/65tZt2TpV9EMIaXbfKTRBhK7JVds4SJ7XGuDL1j
7cpdACCB8jIds8oe3kP3sdeVIK412QlbT9vNZoy+gxXvt22BNJ13jd/AsM4FV72+
17hbaFtzG2I+SbrBBnATTrdZRsvUWN67Taa1MhFpYTwM2JrcSuhJhxvjW6X6XFir
o1sExLmXwPn99SKCuX+18Evqpc3S0q+0OmJGv87ZoqVLBZrFc6zHiCAa9zkMAhMB
nJ3JMU4EZhwUU5jspIcKzTmTL3eItrT/gYdfmKHXC8Zfybj5lfSEp/wXZkF9mUHm
SlaJ55pNAK+976ZXsb03
=PlaW
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
