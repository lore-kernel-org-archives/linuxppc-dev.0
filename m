Return-Path: <thierry.reding@gmail.com>
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com
 [IPv6:2a00:1450:400c:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A63441A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 19:48:33 +1000 (AEST)
Received: by widjs5 with SMTP id js5so51221698wid.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2015 02:48:30 -0700 (PDT)
Date: Thu, 9 Apr 2015 11:48:28 +0200
From: Thierry Reding <thierry.reding@gmail.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH V2] tty: serial: Add const to struct uart_ops declarations
Message-ID: <20150409094827.GI12103@ulmo>
References: <1428169665.2775.53.camel@perches.com>
 <a938a0e86638588e5ccff85771fa3b95@agner.ch>
 <1428258294.2775.69.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mhOzvPhkurUs4vA9"
In-Reply-To: <1428258294.2775.69.camel@perches.com>
Cc: linux-ia64@vger.kernel.org, kernel@stlinux.com,
 Nicolas Ferre <nicolas.ferre@atmel.com>, Timur Tabi <timur@tabi.org>,
 Stefan Agner <stefan@agner.ch>, Patrice Chotard <patrice.chotard@st.com>,
 Pat Gefre <pfg@sgi.com>, Laxman Dewangan <ldewangan@nvidia.com>,
 "Maciej W. Rozycki" <macro@linux-mips.org>, Daniel Walker <dwalker@fifo99.com>,
 sparclinux@vger.kernel.org, Sonic Zhang <sonic.zhang@analog.com>,
 Jiri Slaby <jslaby@suse.cz>, Alexandre Courbot <gnurou@gmail.com>,
 Russell King <linux@arm.linux.org.uk>, Michal Simek <michal.simek@xilinx.com>,
 =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-serial@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>,
 Stephen Warren <swarren@wwwdotorg.org>, linux-arm-msm@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 linux-tegra@vger.kernel.org, David Brown <davidb@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org, Maxime Coquelin <maxime.coquelin@st.com>,
 Barry Song <baohua@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Tony Prisk <linux@prisktech.co.nz>, Bryan Huntsman <bryanh@codeaurora.org>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <kernel@pengutronix.de>,
 Vineet Gupta <vgupta@synopsys.com>, nios2-dev@lists.rocketboards.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "David S. Miller" <davem@davemloft.net>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--mhOzvPhkurUs4vA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 05, 2015 at 11:24:54AM -0700, Joe Perches wrote:
[...]
>  drivers/tty/serial/serial-tegra.c           | 2 +-

Acked-by: Thierry Reding <treding@nvidia.com>

--mhOzvPhkurUs4vA9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJVJkrqAAoJEN0jrNd/PrOh45MP/3gSYsW+iLTl6x31M/1w3yG5
Bbh0OsyQ9lCEtTmbpLR0fLf8G7p5BonsghFrt98B0rzRBMwnXGhE5/9p0daLOE3K
3tyu2w1OAxcXuOatR8SDWkXex/lNLvNxDKUMPDvrvJtI5zVrfIRsG7FTp7zQkupV
jWGCR9j59RFkLAyz1A0avgCbOGl11xVin1d+EUD2ZCrTwxl5FiuV2Ar2E7/7hh04
NsghKA4FLAfZZiyYJ5Lc+7VHqqlk5araKzUOHee1eKi19ntmC6PYbYz2dbMEzcCt
xpKUEe7jrIqhqZjWfOws6GWUy5GTN8zrxlqPjf1D9wWX8bVUK5/n2wQYTrf91exg
3K668MqIYosS044FhFSu+0hXq42Q4BcsMlI9SLjJaVvjs/9uUuXdCtKO0tHN4qfj
9SbgPQ5eKCVX23VJX5BsKD8RxhxSAes5ELi851yvtap7SUSF8QQ5IUp8BZ6Wk5iD
1/F1ZmCggM0BHK5uOE1Omv8t2/Mvj/7vNXzU6uHxl7iPKe6lmVEJQkwrH+qzwtWL
heunoQ0JmW+vsbkJsJdia23ybd6im3RUszQ1no1IBJqUeG8QuGFUAcNcad4H931m
EocSXdQJqiDb82MgylCRfPrwL5s4YpAF+xaVeMm75CWwKXGP1aaywXLbkW40JVWj
C/WJI66kI+i093rg6DmD
=7FoG
-----END PGP SIGNATURE-----

--mhOzvPhkurUs4vA9--
