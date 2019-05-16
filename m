Return-Path: <SRS0=kVu9=TQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E779C04AAF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 May 2019 15:14:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA9C020657
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 May 2019 15:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA9C020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 454ZhR5qPyzDqbm
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 May 2019 01:14:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cyphar.com
 (client-ip=2001:67c:2050:104:0:1:25:1; helo=mx1.mailbox.org;
 envelope-from=cyphar@cyphar.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=cyphar.com
Received: from mx1.mailbox.org (mx1.mailbox.org
 [IPv6:2001:67c:2050:104:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 454Zfg2nJszDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2019 01:12:40 +1000 (AEST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested)
 by mx1.mailbox.org (Postfix) with ESMTPS id EE3654ECCC;
 Thu, 16 May 2019 17:12:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
 by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de
 [80.241.56.117]) (amavisd-new, port 10030)
 with ESMTP id XV0bnWpzQT6y; Thu, 16 May 2019 17:12:21 +0200 (CEST)
Date: Fri, 17 May 2019 01:12:02 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1 1/2] pid: add pidfd_open()
Message-ID: <20190516151202.hrawrx7hxllmz2di@yavin>
References: <20190516135944.7205-1-christian@brauner.io>
 <20190516142659.GB22564@redhat.com>
 <20190516145607.j43xyj26k6l5vmbd@yavin>
 <20190516150611.GC22564@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ndso2fpbrge26y3v"
Content-Disposition: inline
In-Reply-To: <20190516150611.GC22564@redhat.com>
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
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-mips@vger.kernel.org, dhowells@redhat.com, joel@joelfernandes.org,
 linux-kselftest@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-api@vger.kernel.org, elena.reshetova@intel.com,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, dancol@google.com,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Christian Brauner <christian@brauner.io>, serge@hallyn.com,
 linux-xtensa@linux-xtensa.org, keescook@chromium.org, arnd@arndb.de,
 jannh@google.com, linux-m68k@lists.linux-m68k.org, viro@zeniv.linux.org.uk,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 linux-parisc@vger.kernel.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org, luto@amacapital.net, ebiederm@xmission.com,
 linux-alpha@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


--ndso2fpbrge26y3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-05-16, Oleg Nesterov <oleg@redhat.com> wrote:
> On 05/17, Aleksa Sarai wrote:
> > On 2019-05-16, Oleg Nesterov <oleg@redhat.com> wrote:
> > > On 05/16, Christian Brauner wrote:
> > > > With the introduction of pidfds through CLONE_PIDFD it is possible =
to
> > > > created pidfds at process creation time.
> > >
> > > Now I am wondering why do we need CLONE_PIDFD, you can just do
> > >
> > > 	pid =3D fork();
> > > 	pidfd_open(pid);
> >
> > While the race window would be exceptionally short, there is the
> > possibility that the child will die
>=20
> Yes,
>=20
> > and their pid will be recycled
> > before you do pidfd_open().
>=20
> No.
>=20
> Unless the caller's sub-thread does wait() before pidfd_open(), of course.
> Or unless you do signal(SIGCHILD, SIG_IGN).

What about CLONE_PARENT?

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--ndso2fpbrge26y3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb6Gz4/mhjNy+aiz1Snvnv3Dem58FAlzdfcIACgkQSnvnv3De
m5+LBg//TwYfNfdVTd12qfs8hOPFa2sx2DG90Wu3gEQ0F/cxogi+efP+RY/o+vPT
i0FYUiX+aGQ5bpWOfMVytL5PElsRY03f8GZSbweGW0m2y7Kb2cH+wx6qxe2s4RKI
JiNQ6UEIZcAHybLLKlbSaiIYMO1xmZxALchF/Nopq4lVDxpEKhOd8tJaZ5MWTQpi
WCGuVct2Mq+z2FVkdRZl0CXoSf4usXm/bGe/3P1Z/6ZllIwheasZP5whVSybpQa/
oDYZPJOHaPtKJ1DrXO3Qx5j17hltS97pT4DPWi/ad3AqMgHTdFoeuJOSLJzYZ3/d
XFiu4svN/b+dzLj75k+ki4HwbUln+Zz0mnHkgLRYUWC9a7j3bOf2qBxx3eWCIhbz
rRnc+kSy0Qu44pli5inNmPJF66MxVgMkvJtq1fmderaaywkBDjcgrsc7M9ScxUbW
CfPKBIhSZgmfUYqG+NCGXcgJEv4iI3xkFwWfOXGnCjYSoQkgIcJvszd3cVwacLX9
KImzTDjcb50CuNFbYtL5nOHjXl5cHDtsvASzSFZ1FIBZAwiXXnqQE2/byust72VY
WpysP1WuZmkwYLs13DebotUCbSQsvFvyZO6DXuY7JgYXz+rSCdTF4+vG7mjqg3Uo
UZk1XcunD1in53UE3nG2qfE9ayfhvwq6wQ+iSDdyfhDa9ocBjg8=
=utbj
-----END PGP SIGNATURE-----

--ndso2fpbrge26y3v--
