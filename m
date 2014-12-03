Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x230.google.com (mail-pd0-x230.google.com
 [IPv6:2607:f8b0:400e:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D7BE1A0287
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Dec 2014 17:23:34 +1100 (AEDT)
Received: by mail-pd0-f176.google.com with SMTP id y10so14753502pdj.7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Dec 2014 22:23:32 -0800 (PST)
Date: Wed, 3 Dec 2014 14:23:22 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 0/3] fix a kernel panic on fsl corenet board when
 CONFIG_CLK_PPC_CORENET is enabled
Message-ID: <20141203062322.GC13972@pek-khao-d1.corp.ad.wrs.com>
References: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
 <1415333263.23458.417.camel@snotra.buserror.net>
 <DM2PR03MB574DB4A270F85EB73EB76CDFA710@DM2PR03MB574.namprd03.prod.outlook.com>
 <1417567137.15957.229.camel@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ALfTUftag+2gvp1h"
In-Reply-To: <1417567137.15957.229.camel@freescale.com>
Cc: Tang Yuantian-B29983 <Yuantian.Tang@freescale.com>,
 Gerhard Sittig <gsi@denx.de>, Mike Turquette <mturquette@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Lu Jingchang-B35083 <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--ALfTUftag+2gvp1h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 02, 2014 at 06:38:57PM -0600, Scott Wood wrote:
> If the current code panics as of commit da788acb2838, then the revert
> (but not the other patches) should go to stable as well.

OK, I will make a respin to cc stable and add yours and Michael's ack.

Thanks,
Kevin

--ALfTUftag+2gvp1h
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfqxaAAoJEJNY7TDerrFxQV8H+gLfiIorkce4VHmIj5JVNyOB
vZT8eJjTRb8ySUUpCvCyvDZ+iXcBEoDXE8vq0vNQ4MkeAUC+riOO53gkjUQVxO+x
m5AR2u4mKnPqKaoupIy2C6ya1dBYJbRHhGsl35NmVe6LLj3Z0M9y4zDv07DqQNiV
i8u+lqOcJutHzti0/tVYjxfdt9zUBWHmcLEVPvzY6DTQ16CGkzd0k869blNYXUWl
v1RL3TvwxfXBaiRoqAUAEbI6Xio/iSfdSNR269zY62chsD96TQlReyROUHpFsn7z
ZSLONi6jnmBLGhOg2tBsqezKwCOJ5BhrNPxfurnvBPIb4lVVYjA9UpIx2XQ2MpY=
=YfX2
-----END PGP SIGNATURE-----

--ALfTUftag+2gvp1h--
