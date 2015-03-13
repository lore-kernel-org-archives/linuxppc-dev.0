Return-Path: <haokexin@gmail.com>
Received: from mail-qg0-x22b.google.com (mail-qg0-x22b.google.com
 [IPv6:2607:f8b0:400d:c04::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D19AD1A051E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 17:09:22 +1100 (AEDT)
Received: by qgdz107 with SMTP id z107so23722769qgd.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 23:09:20 -0700 (PDT)
Date: Fri, 13 Mar 2015 14:09:13 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Torsten Duwe <duwe@lst.de>
Subject: Re: [RFC] powerpc: use ticket spin lock for !CONFIG_PPC_SPLPAR
Message-ID: <20150313060913.GC24485@pek-khao-d1.corp.ad.wrs.com>
References: <1426157723-28548-1-git-send-email-haokexin@gmail.com>
 <1426158807.17565.131.camel@kernel.crashing.org>
 <20150312152410.GA12372@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
In-Reply-To: <20150312152410.GA12372@lst.de>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2015 at 04:24:10PM +0100, Torsten Duwe wrote:
> But generally, which platforms would benefit most from this change?

In theory, the more cpus the platform has, the more serious the thundering
herd problem is. So the latest platforms which has more cpus would benefit
most.

Thanks,
Keivn

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVAn8JAAoJEJNY7TDerrFx+DMH/js7mUGgmeuJfooGibhxVpkw
HoH3suDEw0PDS8r65bDlLIjAHab+BbvS2K7XJTkCJzF38XcxTE2IOadCSaoEBAbe
Sge8clWnXQwjXLpqq+dfwlBerLRzihWfOJ7vE4fhAFoeNJmszHwKTg63ahd8NUE6
3JUF3kK9nqsHJujPwHca5JvQCqbyc3fiXRhpwYOtPCtPd7WWLaDWP76kdJerXiex
HDRyK54ZNyCxYRL4ps/72wZJPVP0ghy8xGYpIYTAcrrcfb140tznAyz/nQbCMYd1
efsHPBhrf4yeDJHtLJ1EUESukE1pj7AU7WADzEj9OfBVKXR5N6YBauz5nSc6+q4=
=1gzv
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
