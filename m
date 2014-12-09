Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1DB8B1A05EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 12:34:26 +1100 (AEDT)
Received: by mail-pa0-f41.google.com with SMTP id rd3so6326364pab.14
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Dec 2014 17:34:24 -0800 (PST)
Date: Tue, 9 Dec 2014 09:34:15 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>,
 Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v3 1/3] Revert "clk: ppc-corenet: Fix Section mismatch
 warning"
Message-ID: <20141209013415.GB20874@pek-khao-d1.corp.ad.wrs.com>
References: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
 <1417596833-31456-2-git-send-email-haokexin@gmail.com>
 <1417751519.334.9.camel@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
In-Reply-To: <1417751519.334.9.camel@freescale.com>
Cc: Yuantian Tang <Yuantian.Tang@freescale.com>, Gerhard Sittig <gsi@denx.de>,
 linuxppc-dev@lists.ozlabs.org, Jingchang Lu <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 04, 2014 at 09:51:59PM -0600, Scott Wood wrote:
> This patch is going to conflict with commit a4ae8f3b0f7ac6ab3 "clk: drop
> owner assignment from platform_drivers" in linux-next -- or rather,
> you've based this on that patch, but it's not in mpe's next branch, so I
> get a merge conflict and there'd be another merge conflict later on to
> get back to the newer base.
>=20
> I really think this should go via the clock tree.  That's where the
> breakage was introduced in the first place...

Hi Mike,

Could you pick up these patches?

Thanks,
Kevin

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhlGXAAoJEJNY7TDerrFxXaUIAMOgvQ1ThUesaoVdDa8kpvbH
TlLzzPH7CLlASQDX7m2SmeBvlwyQ6U21E67453YCf9Z4V10rrEDCGTl/xSTnJvT+
bxxl6KA4+fj7ZZ3HoZEfUesSDem9FprtG6qVcFFKcOwUGyc7czT+De+ip1pAOnDl
xg62FTz7YP0d5QLRhUnv5DO8Dbcu/qCMKpy9kBnEAjuieHN97/FW24YHqiY6LFee
71BcqdlPlWBxSA2lpLv8GsgSvlkdJPVor4bYgxG1asPfF/Zl08GW4hLf3DYglYic
HLVcqBkxbpPhVMENP7I6sgKDSLRDpYgHQ4OW+NEdfVl3ltafv2iIT4XJsy8+oIA=
=QYYW
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
