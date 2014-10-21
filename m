Return-Path: <haokexin@gmail.com>
Received: from mail-pd0-x235.google.com (mail-pd0-x235.google.com
 [IPv6:2607:f8b0:400e:c02::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FB511A0029
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 19:10:40 +1100 (AEDT)
Received: by mail-pd0-f181.google.com with SMTP id w10so833332pde.40
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Oct 2014 01:10:37 -0700 (PDT)
Date: Tue, 21 Oct 2014 16:10:28 +0800
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 0/3] fix a kernel panic on fsl corenet board when
 CONFIG_CLK_PPC_CORENET is enabled
Message-ID: <20141021081028.GA22757@pek-khao-d1.corp.ad.wrs.com>
References: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
In-Reply-To: <1413699099-25743-1-git-send-email-haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, Gerhard Sittig <gsi@denx.de>,
 Mike Turquette <mturquette@linaro.org>,
 Jingchang Lu <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2014 at 02:11:36PM +0800, Kevin Hao wrote:
> Hi,
>=20
> I have done a boot test on p2014rdb and t4240qds boards. I don't have an =
access
> to mpc512x board, so only build test for that.

I do find a mpc5121ads board in our lab, the kernel boot well with these ch=
anges.

Thanks,
Kevin

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJURhT0AAoJEJNY7TDerrFxfoMH/0z7VAwLBUfVAlDRHAkmOjLf
9j8RBlrUUtUIPzeKvaY2Opr9vzqRMh2EnfiABqoW8pLIgzCQS1bdBB23dc/6i2GP
KlE05oMCAb8BorExUkCa56UoDvPWIWRthgt628P3FNDiNB8bBpZnioR4EqXafPcr
71z5u279LPjj5IiQqIjCbJhCwy/d4sGcGLiLWCB9aQYNkq6ydn6DUOiVp556Vjuj
rZeHwUMVwPdgM6TeMZ9Od+KgpIfBnh7jjsLz68Da/exuKNgxqXz7O9JwShG6WXeH
epMassgyXF9CmVtFAGpboNt++K2ekug45RWOrjzWfFe84qiDidkUQwPNQUIRQQ8=
=6Gs8
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
