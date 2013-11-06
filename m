Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 26C192C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 21:03:46 +1100 (EST)
Date: Wed, 6 Nov 2013 10:03:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Li Xiubo <B47053@freescale.com>
Message-ID: <20131106100305.GI11602@sirena.org.uk>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-6-git-send-email-Li.Xiubo@freescale.com>
 <20131101185045.GG2493@sirena.org.uk>
 <1DD289F6464F0949A2FCA5AA6DC23F82876EFF@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F82876EFF@039-SN2MPN1-013.039d.mgd.msft.net>
Subject: Re: [PATCHv2 5/8] ASoC: SGTL5000: Enhance the SGTL5000 codec driver
 about regulator.
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "tiwai@suse.de" <tiwai@suse.de>, Huan Wang <B18965@freescale.com>,
 "timur@tabi.org" <timur@tabi.org>, "perex@perex.cz" <perex@perex.cz>,
 Shawn Guo <r65073@freescale.com>,
 "LW@KARO-electronics.de" <LW@KARO-electronics.de>,
 "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
 Guangyu Chen <B42378@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "ian.campbell@citrix.com" <ian.campbell@citrix.com>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
 "rob.herring@calxeda.com" <rob.herring@calxeda.com>,
 "oskar@scara.com" <oskar@scara.com>, Fabio Estevam <r49496@freescale.com>,
 "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "rob@landley.net" <rob@landley.net>, Zhengxiong Jin <R64188@freescale.com>,
 "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 06, 2013 at 08:59:53AM +0000, Li Xiubo wrote:

Please fix your mailer to word wrap within paragraphs.

> The SGTL5000 is based on regulators and when it is disabled, there
> will be an error returns directly while the SGTL5000 codec is probing.

What makes you say this?  That's not how the regulator API works.  Have
you actually seen any problems?

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSehPWAAoJELSic+t+oim99j8P/0Q5VxOl7Cz2kOdpkUtx05aO
zfsY9qshNzATK+jYfwNtZpX1HNqQqNLyb9Yrbwcwt/w0fHG3TNOlX22yN1B0zNP3
31rbjJ8j8VlYknZU9Ht8wxixe9MiUgZfZFxZD+m9J5PJm3kRD47eM5KGUq4J42B4
ZmlEjfTXyhfeIkZmK2UYQmqIFmNLsN4geLH3KdyeKpGIMG7SJpKkEnt21MtvdCXP
dv3Im3P1/+GJDaC9ygXvZrBhmKenQyxnOk7aBshU4n8nRdU5Cx2aa+DYPMocA/8t
zFNguQriZQk5T9RaOGv8LxXNhuCUpTMpiKGaKt/4v3/KbtuuZRHXiFWYZKAqcYcR
jYMmpzIanQGedpAndpM/NsdqzhuEf5pmj43wwzeJY0ky3sn6jPEqBVRiPNJ0mRir
/zOxppmx4OKeBsAxsiHMBcyqcr1xgZqHhjCzz7UB0aeSZAhHgHgTf/AmvAYF+/XZ
hC/NQcojgd3ik/nFATsSIiW0ByDgMzWWt+7xssB4eZ8TvGnwQMUvK354NLODPRzr
bOwTmbavXmhjziSQhqZe98VD4SAp8xL63RIxfQO/0Qc1KtoyQZ5/RFdRNA+vjbcQ
Oa3EbyyltfT8SbF+uZr0Pxnby+YTN42AbTj2PrefRNJ1CngTxvzKcjkdrxWa++SJ
aKaPNTTIaZfBZXE2HIBG
=lgFY
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
