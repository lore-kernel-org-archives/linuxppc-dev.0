Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94726C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:52:39 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CE8120851
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 22:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE8120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4380d10X3XzDqP3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 09:52:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.15.15; helo=mout.gmx.net;
 envelope-from=j.neuschaefer@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
X-Greylist: delayed 349 seconds by postgrey-1.36 at bilbo;
 Tue, 04 Dec 2018 09:02:41 AEDT
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 437zWP2tqQzDqNf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 09:02:41 +1100 (AEDT)
Received: from longitude ([87.79.84.57]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MWTfu-1h1XjS0u6c-00XbNn; Mon, 03
 Dec 2018 22:56:05 +0100
Date: Mon, 3 Dec 2018 22:55:58 +0100
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v1 03/13] powerpc/mm/32s: rework mmu_mapin_ram()
Message-ID: <20181203215558.GK15324@latitude>
References: <cover.1543517818.git.christophe.leroy@c-s.fr>
 <8835330baa77d88e0267b0b1215b78c991e6d17a.1543517818.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline
In-Reply-To: <8835330baa77d88e0267b0b1215b78c991e6d17a.1543517818.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:LOSPz25wnZaZbdRbnDyYPrZwko0HsusJN9bRjOtQ4TquWHlxyE9
 zj2+7XDUDg7H1pW3lj28PVAx7gMsZS5IPjeN0ew0nizKDQSHcVOgPk1gdZVt7nR7tPeYYe8
 agoXoEbpnLVVOriyvU5CrQxvsvzgJnC14dYhslqWoMlPQ/fgmiIg20mWvnhVWuFNvM5Urdr
 1nkyvOnSN9brwMZzHcMiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iNmaZUH6o4U=:63vpdQ/hpx2X9sjBd9AK9F
 w87laMWFeABDtAkhLw9xcKSwi9NQgKOeGl4lryKK0ajFdDoLmaeBEIb+ImwUv7mCyrjJE/svn
 eDeaKb5jo8k45DUZzLlcIyqMZuF4evSpIQ2qvUYuCpMuT2U4jvFET9KevG/7xlL6DAB0rOBSS
 J0luFDL/7F65c4uWvl06qgmCLRlYRm1Z0zUo8s2pD4ZGP3tduPrpna/jCk+RqnJaci1Pg4ToH
 xgzymPPyeALIMBvxHS9V18riPAmL7Bmr4CbVgtswnoGbv3mGCJGxVLIWN1zs2HZYxYUttln3p
 0hg+KiDtJcCGCXsx0+pkd5RHGav3r5zTuwDL/FuwhQQeKS+SvgNM5yrz+XV3sBhGDQ/sLZ6wM
 /OWd+K/i+OgdYOJNAFq9g7vcdxz2AMfznCYOdeTAfzdYa/lT1y2PXEKxQMd2ZG8GikfZs2OdI
 efyuydI41mO4VQueEqIFoqXHERbZNI/yjYJYY1oPYsJ4VXt8fSkMF2n3+/NI8W65SqX868ftK
 qCfY2ropYcK5AG0hdHDr1CRhXSHC4mAH20+1qvN9pbyDwIkp5N/aLGgVU5bm49iCACgvBcisp
 C68b6ZMCFMTtXEchq+zLmVtJrBVDlh6D8VcSVCafbpouzxMeoIuw+7nmqPjUqewrf0dLtBNwS
 lxrAJHy+2+IijibgUQlMYUEXK8GPDRRVuKnYbJkQ5zA9Jv4Y5Qk82kfqJkqswn33rYMbCR8sD
 6TEJQunyrzYcyZKAw3jLXMcP3YmJkycFEa3Zk/2ZmT9aGDNXfR0BSW06GG7+vY9E4xEwq7C9C
 HHu6iyF83TxLstmne3SiyE1zOCiHgLYErFnadZgm+iLe14qFZ6VgWH4FbhabJm9P+eyNURL88
 nqLPWG6wo+BVt+az/KOzVpxSlCpBOVC+bBj9YIF2DraHrqkuKGnCtQJO9Jf77v
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 29, 2018 at 07:00:16PM +0000, Christophe Leroy wrote:
> This patch reworks mmu_mapin_ram() to be more generic and map as much
> blocks as possible. It now supports blocks not starting at address 0.
>=20
> It scans DBATs array to find free ones instead of forcing the use of
> BAT2 and BAT3.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---

I've just tested this series on my Wii, and starting from this patch
(03/13), it hangs at the following lines of output:

[    0.000000] printk: bootconsole [udbg0] enabled
[    0.000000] Total memory =3D 319MB; using 1024kB for hash table (at (ptr=
val))

Before this patch it looks like this and boots to userspace:

[    0.000000] printk: bootconsole [udbg0] enabled
[    0.000000] Total memory =3D 319MB; using 1024kB for hash table (at (ptr=
val))
[    0.000000] Linux version 4.20.0-rc5-wii-00022-gfbb911b84755 (jn@longitu=
de) (gcc version 8.2.0 (Debian 8.2.0-9)) #1337 PREEMPT Mon Dec 3 21:49:02 C=
ET 2018
ug_udbg_init: early -> final
usbgecko_udbg: ready
[    0.000000] Using wii machine description
=2E..

I've tested at patch 1, 2, 3, 4, and 13, so I don't know if it works
somewhere in the middle, but probably not.

(And in case you're wondering about the 22 in the version string: Those
are mostly patches that give me a serial console.)

I'm not sure what is going on, because I haven't looked closely at the
patches or tried to debug the problem. If you have some debugging tips,
I can try them.


Jonathan Neusch=C3=A4fer

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlwFpmUACgkQCDBEmo7z
X9tjQhAAtgGfhvYKAZs5YH93HGyareHmVqRSSg59aSnlMwaTZhLNHTix+xkwCgRQ
i8mr6oA83S5B79HehInblEfrDh0FGluPBrUfhK/bTQOmJ4Cqk8ur4MHIEmBGiy3X
2Py2zXCeuK4K7YOPCqfJmmuPTo+qviQe8ya2i1TPyZ1IqwqnLJ5jstLBs8Yyfm4o
y8azYiRZ43cJyhZ7bI1I6L4Y8oFYG06TLSe8yRaRHWO6iOhbEcv1ANUZ0Lz/Azn2
n0xWB4GhcS+cCJNzzYHjZqXQWWtWElDbuuXYh5kgUQAHZWgFNzCMjm5pd1WysiJk
rxUyaaHTShibBgBz8KRMfXpJBUg6Ux4t86t2JdopbZCJ5fnXY8QFHEMCVpcak7v9
YDlX8ABaxC0s2ykxE9HFF6nrlkYQUk0pmbeqqEZN/vUV1lAQr2tlVap9s2ZwJdIP
HUhhA12LBkOJx5q31wNip2k0cuvM6IjdHSrImjTNb37yHqsGaXCu+TWaWSmzXA/B
f3/7TLY+chXqxUCawpPgeYz53fy4Y9opNjD3hzDzzFD9PcRFzyixl7fM9wlgE37w
D7UNNZ18ky7LKMuL+5RpbH41dGILkku3tPHflc+h0v+RCJacL3h+uDr3+w7Y8br7
D0zb7tVOQZwK8rbIoRzLPgsuU/aE2+3oC6fdLM2utgF7WwG/jlo=
=J3qj
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--
