Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7D0081A06F9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Aug 2014 20:06:07 +1000 (EST)
Date: Thu, 7 Aug 2014 11:05:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Message-ID: <20140807100553.GF17528@sirena.org.uk>
References: <1407223925-29678-1-git-send-email-nicoleotsuka@gmail.com>
 <20140807094527.GC17528@sirena.org.uk>
 <20140807094404.GB3088@MrMyself>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="RPBrhutAYpIit0OE"
In-Reply-To: <20140807094404.GB3088@MrMyself>
Subject: Re: [PATCH] ASoC: fsl_sai: Add asynchronous mode support
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
 b42378@freescale.com, b02247@freescale.com, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, timur@tabi.org, Nicolin Chen <nicoleotsuka@gmail.com>,
 Li.Xiubo@freescale.com, galak@codeaurora.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--RPBrhutAYpIit0OE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 07, 2014 at 05:44:05PM +0800, Nicolin Chen wrote:
> On Thu, Aug 07, 2014 at 10:45:27AM +0100, Mark Brown wrote:

> > Might be worth printing an error here.

> Hmm...Do I need to send a v2?

Send an incremental patch.

--RPBrhutAYpIit0OE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT409+AAoJELSic+t+oim9ysYP/A0CFYRbS/nhwGKrxjI9PRJt
/xGfd+Ke39ZYSMy+lW2rXlvmK3yHnHQd68fr64cdH148dEZD2eYlfrzcjpC0kGOb
Ax0tkjXhRjd5axgmPLqCmSTLXmg+DeTiqk+ReOsXLj/M6qYrPhMY5p39/9KvnGwj
Hw5PuUWaeS7+K91NIwFgWFYilxQx+Z3WXXN7++3UfRdh6v7Xr/czp4CgzaBGO94z
idji4VUxO66tERbU8iakdXlwSpzCuT6WhuN1taKZboCyPEQh/CFZdJtMm/NDzKwI
XrtLnA5o6HATngQpRw+lwOUsdZZUvvsKD1ob8dFOeTUXFE1mPDMiL5GN4tAkOFJy
WaFQiX9JjZoF0TYr3YsI5hNwgJL9mJNeo+bcSsfZ2p+EAMptkk28apRsVXiRKC1r
vBet+/vba6MbQAP9TakJICUMdUBbqRw8GM+u1uT2+0VqCypAls7gv/ojwKhisyuh
2v33tiBtqhI0Ho99QyCBpEXNlzU78T1xMAgkcXST1RFrBLoomYJxwXSaDa7wyLi/
SyiHRZYgvoKgni446skmTt7NYFCZmAEjpBhzjTyQ/Bk9ADm7r/qdOyNl6pWc0PUE
tlpX6K4Btr/KGQPgdIhruXgYh8jjNpcfJKaKK/dP5jRQ14PL3ow3pC5MBN4Kpj4H
gsjT/Dl07Fg9DDTt4wRz
=KJ79
-----END PGP SIGNATURE-----

--RPBrhutAYpIit0OE--
