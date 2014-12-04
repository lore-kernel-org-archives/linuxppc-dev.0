Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x22c.google.com (mail-pd0-x22c.google.com
 [IPv6:2607:f8b0:400e:c02::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6CD031A011D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 17:07:02 +1100 (AEDT)
Received: by mail-pd0-f172.google.com with SMTP id y13so17006350pdi.17
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Dec 2014 22:07:00 -0800 (PST)
Date: Thu, 4 Dec 2014 14:06:52 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v3 1/3] Revert "clk: ppc-corenet: Fix Section mismatch
 warning"
Message-ID: <20141204060652.GC14597@pek-khao-d1.corp.ad.wrs.com>
References: <1417596833-31456-1-git-send-email-haokexin@gmail.com>
 <1417596833-31456-2-git-send-email-haokexin@gmail.com>
 <1417665891.15957.238.camel@freescale.com>
 <20141204043816.GB14597@pek-khao-d1.corp.ad.wrs.com>
 <1417668384.15957.240.camel@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
In-Reply-To: <1417668384.15957.240.camel@freescale.com>
Cc: Mike Turquette <mturquette@linaro.org>, Gerhard Sittig <gsi@denx.de>,
 Yuantian Tang <Yuantian.Tang@freescale.com>,
 Jingchang Lu <jingchang.lu@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 03, 2014 at 10:46:24PM -0600, Scott Wood wrote:
> Since only this first patch is a critical bugfix, and there's no
> arch/powerpc content in that patch, I think it should go via Mike's tree
> if it's to go in for 3.18 (if it's not already too late).  Or, to keep
> things simple given the dependency of the following patches, we could
> batch them all together for -next and add a # 3.18 stable request.

We don't need to explicitly add a #3.18 stable request in this case. As I know,
we only need to indicate the first version which is affected by the bug fixed by
this commit in the cc tag. This would imply that the applicable stable kernel
version rang should be from 3.17 to the previous version of the kernel which
finally merge this commit.

Thanks,
Kevin

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUf/n8AAoJEJNY7TDerrFxiL4IAJ/Lm2e5cnp6EKqtMkuuV5PE
5iEsC6ZUTpf8ZFnIJZrjJ3GiLPowooFIX3C8qM7p7hVQOEdpAoEPkfomDNVswmHY
89NO1xVPNXbAtOjl4b8857PpG1vN8ddF2EYvyCzqrQWozwq1Jdn5KxARjqy5i0ey
bRlBi7QM/N8uMFOO457dPXjF8BznZ4nRS4s7NGg+WnnoXJLwRAiVfLhu0JTj+cFZ
NfKjDTtzej+fUHy37TvtpYEoxZ/IaNztYQ5c7DQB/p3uPTZ7FkFyUXDX0cOjKWJp
FrM04ofle8LW29d+1ixjhILEZP2Imf14bpjV7Qml5iPsErSebSIFMZGVXhzSecg=
=dJG6
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
